import 'dart:async';
import 'dart:math';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/stock_model.dart';
import '../models/portfolio_model.dart';
import '../models/stock_event_model.dart' as models;
import '../models/stock_event_model.dart';
import '../data/initial_stocks.dart';
import '../data/stock_events.dart';
import '../../data/repositories/asset_repository.dart';
import '../../data/repositories/stock_repository.dart' as repo;
import '../../asset/asset_bloc/asset_bloc.dart' as asset;

part 'stock_event.dart';
part 'stock_state.dart';
part 'stock_bloc.freezed.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  Timer? _priceUpdateTimer;
  final Random _random = Random();
  final AssetRepository? assetRepository;
  final repo.StockRepository? stockRepository;
  StreamSubscription? _cashSubscription;
  StreamSubscription? _stocksSubscription;
  StreamSubscription? _portfolioSubscription;

  StockBloc({this.assetRepository, this.stockRepository}) : super(_initState) {
    on<_Started>(_onStarted);
    on<_BuyStock>(_onBuyStock);
    on<_SellStock>(_onSellStock);
    on<_UpdatePrices>(_onUpdatePrices);
    on<_TriggerEvent>(_onTriggerEvent);
    on<_ClearEvent>(_onClearEvent);
    on<_SelectStock>(_onSelectStock);
    on<_StocksUpdated>(_onStocksUpdated);
    on<_CashUpdated>(_onCashUpdated);
    on<_PortfolioUpdated>(_onPortfolioUpdated);

    // AssetRepository의 cashStream 구독
    if (assetRepository != null) {
      _cashSubscription = assetRepository!.cashStream.listen((cash) {
        add(StockEvent.cashUpdated(cash));
      });

      // AssetRepository의 stocksStream 구독 (포트폴리오 동기화)
      _portfolioSubscription = assetRepository!.stocksStream.listen((assetStocks) {
        add(StockEvent.portfolioUpdated(assetStocks));
      });
    }

    // StockRepository의 tradableStocksStream 구독
    if (stockRepository != null) {
      _stocksSubscription = stockRepository!.tradableStocksStream.listen((tradableStocks) {
        // TradableStock을 Stock 모델로 변환 (간단하게)
        final updatedStocks = tradableStocks.map((ts) => Stock(
          symbol: ts.ticker,
          name: ts.name,
          price: ts.currentPrice.toDouble(),
          change: 0.0,
          volume: 1000000,
        )).toList();

        // Event로 전달
        add(StockEvent.stocksUpdated(updatedStocks));
      });
    }

    // 3초마다 주가 업데이트
    _priceUpdateTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => add(const StockEvent.updatePrices()),
    );
  }

  static StockState get _initState => StockState.data(
        StockData(
          stocks: initialStocks,
          selectedStock: initialStocks.first.symbol,
        ),
      );

  Future<void> _onStarted(
    _Started event,
    Emitter<StockState> emit,
  ) async {
    // StockRepository에서 초기 주식 데이터 가져오기
    List<Stock> initialStockList = initialStocks;
    if (stockRepository != null) {
      final tradableStocks = stockRepository!.tradableStocks;
      if (tradableStocks.isNotEmpty) {
        initialStockList = tradableStocks.map((ts) => Stock(
          symbol: ts.ticker,
          name: ts.name,
          price: ts.currentPrice.toDouble(),
          change: 0.0,
          volume: 1000000,
        )).toList();
      }
    }

    // AssetRepository에서 초기 포트폴리오 가져오기
    List<PortfolioItem> initialPortfolio = [];
    if (assetRepository != null) {
      initialPortfolio = assetRepository!.myStocks.map((assetStock) => PortfolioItem(
        symbol: assetStock.ticker,
        quantity: assetStock.quantity,
        avgPrice: assetStock.avgPrice.toDouble(),
      )).toList();
    }

    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        status: StockStatus.success,
        stocks: initialStockList,
        selectedStock: initialStockList.isNotEmpty ? initialStockList.first.symbol : null,
        currentBalance: assetRepository?.currentCash.toDouble() ?? data.currentBalance,
        portfolio: initialPortfolio,
      )),
      orElse: () => state,
    ));
  }

  Future<void> _onSelectStock(
    _SelectStock event,
    Emitter<StockState> emit,
  ) async {
    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        selectedStock: event.symbol,
      )),
      orElse: () => state,
    ));
  }

  Future<void> _onBuyStock(
    _BuyStock event,
    Emitter<StockState> emit,
  ) async {
    await state.maybeWhen(
      data: (data) async {
        final stock = data.stocks.firstWhere((s) => s.symbol == event.symbol);

        // AssetRepository를 통해 매수 (잔고 확인 및 차감 포함)
        if (assetRepository != null) {
          final success = await assetRepository!.buyStock(
            ticker: event.symbol,
            quantity: event.quantity,
            price: stock.price.toInt(),
          );

          if (!success) {
            emit(StockState.data(data.copyWith(
              errorMessage: '잔고가 부족합니다!',
            )));
            return;
          }
          // stocksStream이 portfolio를 자동 업데이트
        } else {
          // AssetRepository가 없는 경우 에러 메시지
          emit(StockState.data(data.copyWith(
            errorMessage: 'Repository가 설정되지 않았습니다!',
          )));
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onSellStock(
    _SellStock event,
    Emitter<StockState> emit,
  ) async {
    await state.maybeWhen(
      data: (data) async {
        final stock = data.stocks.firstWhere((s) => s.symbol == event.symbol);

        // AssetRepository를 통해 매도 (보유 수량 확인 및 현금 증가 포함)
        if (assetRepository != null) {
          final success = await assetRepository!.sellStock(
            ticker: event.symbol,
            quantity: event.quantity,
            price: stock.price.toInt(),
          );

          if (!success) {
            emit(StockState.data(data.copyWith(
              errorMessage: '보유 수량이 부족합니다!',
            )));
            return;
          }
          // stocksStream이 portfolio를 자동 업데이트
        } else {
          // AssetRepository가 없는 경우 에러 메시지
          emit(StockState.data(data.copyWith(
            errorMessage: 'Repository가 설정되지 않았습니다!',
          )));
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onUpdatePrices(
    _UpdatePrices event,
    Emitter<StockState> emit,
  ) async {
    await state.maybeWhen(
      data: (data) async {
        // 랜덤 이벤트 체크 (15% 확률)
        if (data.activeEvent == null && _random.nextDouble() < 0.15) {
          final availableEvents = stockEvents.where(
            (e) => _random.nextDouble() < e.probability,
          ).toList();

          if (availableEvents.isNotEmpty) {
            final selectedEvent = availableEvents[
              _random.nextInt(availableEvents.length)
            ];

            final duration = selectedEvent.effect.type == EventEffectType.dividend
                ? 0
                : _random.nextInt(8) + 5; // 5~12초

            add(StockEvent.triggerEvent(
              selectedEvent.copyWith(
                effect: selectedEvent.effect.copyWith(duration: duration),
                startTime: DateTime.now(),
              ),
            ));
            return;
          }
        }

        // 이벤트 만료 체크
        if (data.activeEvent != null && data.activeEvent!.effect.duration > 0) {
          final elapsed = DateTime.now()
              .difference(data.activeEvent!.startTime!)
              .inSeconds;
          if (elapsed > data.activeEvent!.effect.duration) {
            add(const StockEvent.clearEvent());
            return;
          }
        }

        // 주가 업데이트
        final baseStockChanges = <String, double>{};
        final updatedStocks = data.stocks.map((stock) {
          double baseChange = 0;

          if (!stock.isLeverage) {
            // 기본 변동률
            baseChange = (_random.nextDouble() - 0.5) * 0.02;

            // 이벤트 효과 적용
            if (data.activeEvent != null) {
              final effect = data.activeEvent!.effect;
              switch (effect.type) {
                case EventEffectType.allUp:
                  baseChange += effect.value;
                  break;
                case EventEffectType.allDown:
                  baseChange -= effect.value;
                  break;
                case EventEffectType.sectorUp:
                  if (effect.sectors.contains(stock.symbol)) {
                    baseChange += effect.value;
                  }
                  break;
                case EventEffectType.sectorDown:
                  if (effect.sectors.contains(stock.symbol)) {
                    baseChange -= effect.value;
                  }
                  break;
                case EventEffectType.randomCrash:
                  if (_random.nextDouble() < 0.3) {
                    baseChange -= effect.value;
                  }
                  break;
                default:
                  break;
              }
            }

            baseStockChanges[stock.symbol] = baseChange;
          } else {
            // 레버리지 상품
            final baseSymbol = stock.baseSymbol!;
            var baseStockChange = baseStockChanges[baseSymbol];

            if (baseStockChange == null) {
              baseStockChange = (_random.nextDouble() - 0.5) * 0.02;

              // 기본 종목에 이벤트 효과 적용
              if (data.activeEvent != null) {
                final effect = data.activeEvent!.effect;
                switch (effect.type) {
                  case EventEffectType.allUp:
                    baseStockChange += effect.value;
                    break;
                  case EventEffectType.allDown:
                    baseStockChange -= effect.value;
                    break;
                  case EventEffectType.sectorUp:
                    if (effect.sectors.contains(baseSymbol)) {
                      baseStockChange += effect.value;
                    }
                    break;
                  case EventEffectType.sectorDown:
                    if (effect.sectors.contains(baseSymbol)) {
                      baseStockChange -= effect.value;
                    }
                    break;
                  case EventEffectType.randomCrash:
                    if (_random.nextDouble() < 0.3) {
                      baseStockChange -= effect.value;
                    }
                    break;
                  default:
                    break;
                }
              }

              baseStockChanges[baseSymbol] = baseStockChange;
            }

            // 레버리지 적용
            if (stock.leverageType == 'long') {
              baseChange = baseStockChange * 2;
            } else if (stock.leverageType == 'short') {
              baseChange = baseStockChange * -2;
            }
          }

          final minPrice = stock.isLeverage ? 100.0 : 1000.0;
          final newPrice =
              max(minPrice, stock.price + stock.price * baseChange);
          final priceChange = ((newPrice - stock.price) / stock.price) * 100;

          final volumeChange =
              (_random.nextDouble() - 0.5) * (stock.isLeverage ? 50000 : 100000);
          final newVolume = stock.volume + volumeChange.toInt();

          return stock.copyWith(
            price: newPrice,
            change: priceChange,
            volume: newVolume,
          );
        }).toList();

        // 가격 히스토리 업데이트
        final newPriceHistory = Map<String, List<PriceHistory>>.from(data.priceHistory);
        for (final stock in updatedStocks) {
          if (!newPriceHistory.containsKey(stock.symbol)) {
            newPriceHistory[stock.symbol] = [];
          }
          newPriceHistory[stock.symbol]!.add(PriceHistory(
            time: DateTime.now(),
            price: stock.price,
            change: stock.change,
          ));

          // 최근 50개만 유지
          if (newPriceHistory[stock.symbol]!.length > 50) {
            newPriceHistory[stock.symbol] =
                newPriceHistory[stock.symbol]!.sublist(
              newPriceHistory[stock.symbol]!.length - 50,
            );
          }
        }

        emit(StockState.data(data.copyWith(
          stocks: updatedStocks,
          priceHistory: newPriceHistory,
        )));
      },
      orElse: () {},
    );
  }

  Future<void> _onTriggerEvent(
    _TriggerEvent event,
    Emitter<StockState> emit,
  ) async {
    await state.maybeWhen(
      data: (data) async {
        // 배당금 이벤트 처리
        if (event.event.effect.type == EventEffectType.dividend) {
          double dividendAmount = 0;
          for (final item in data.portfolio) {
            final stock = data.stocks.firstWhere((s) => s.symbol == item.symbol);
            dividendAmount += stock.price * item.quantity * event.event.effect.value;
          }

          // AssetRepository를 통해 배당금 추가 (모든 화면에서 동기화)
          if (assetRepository != null) {
            await assetRepository!.addCash(dividendAmount.toInt());
          }

          emit(StockState.data(data.copyWith(
            activeEvent: event.event,
          )));

          // 3초 후 이벤트 자동 종료
          await Future.delayed(const Duration(seconds: 3));
          add(const StockEvent.clearEvent());
        } else {
          emit(StockState.data(data.copyWith(
            activeEvent: event.event,
          )));
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onClearEvent(
    _ClearEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        activeEvent: null,
      )),
      orElse: () => state,
    ));
  }

  Future<void> _onStocksUpdated(
    _StocksUpdated event,
    Emitter<StockState> emit,
  ) async {
    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        stocks: event.stocks,
      )),
      orElse: () => state,
    ));
  }

  Future<void> _onCashUpdated(
    _CashUpdated event,
    Emitter<StockState> emit,
  ) async {
    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        currentBalance: event.cash.toDouble(),
      )),
      orElse: () => state,
    ));
  }

  Future<void> _onPortfolioUpdated(
    _PortfolioUpdated event,
    Emitter<StockState> emit,
  ) async {
    // AssetRepository의 Stock을 StockBloc의 PortfolioItem으로 변환
    final portfolio = event.assetStocks.map((assetStock) => PortfolioItem(
      symbol: assetStock.ticker,
      quantity: assetStock.quantity,
      avgPrice: assetStock.avgPrice.toDouble(),
    )).toList();

    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        portfolio: portfolio,
      )),
      orElse: () => state,
    ));
  }

  @override
  Future<void> close() {
    _priceUpdateTimer?.cancel();
    _cashSubscription?.cancel();
    _stocksSubscription?.cancel();
    _portfolioSubscription?.cancel();
    return super.close();
  }
}
