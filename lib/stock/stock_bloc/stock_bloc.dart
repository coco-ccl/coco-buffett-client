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

part 'stock_event.dart';
part 'stock_state.dart';
part 'stock_bloc.freezed.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  Timer? _priceUpdateTimer;
  final Random _random = Random();

  StockBloc() : super(_initState) {
    on<_Started>(_onStarted);
    on<_BuyStock>(_onBuyStock);
    on<_SellStock>(_onSellStock);
    on<_UpdatePrices>(_onUpdatePrices);
    on<_TriggerEvent>(_onTriggerEvent);
    on<_ClearEvent>(_onClearEvent);
    on<_SelectStock>(_onSelectStock);

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
    emit(state.maybeWhen(
      data: (data) => StockState.data(data.copyWith(
        status: StockStatus.success,
        stocks: initialStocks,
        selectedStock: initialStocks.first.symbol,
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
        final totalCost = stock.price * event.quantity;

        if (totalCost > data.currentBalance) {
          emit(StockState.data(data.copyWith(
            errorMessage: '잔고가 부족합니다!',
          )));
          return;
        }

        final newBalance = data.currentBalance - totalCost;
        final existingIndex =
            data.portfolio.indexWhere((p) => p.symbol == event.symbol);

        List<PortfolioItem> newPortfolio;
        if (existingIndex != -1) {
          final existing = data.portfolio[existingIndex];
          final newQuantity = existing.quantity + event.quantity;
          final newAvgPrice = ((existing.avgPrice * existing.quantity) +
                  (stock.price * event.quantity)) /
              newQuantity;

          newPortfolio = List.from(data.portfolio);
          newPortfolio[existingIndex] = PortfolioItem(
            symbol: event.symbol,
            quantity: newQuantity,
            avgPrice: newAvgPrice,
          );
        } else {
          newPortfolio = [
            ...data.portfolio,
            PortfolioItem(
              symbol: event.symbol,
              quantity: event.quantity,
              avgPrice: stock.price,
            ),
          ];
        }

        emit(StockState.data(data.copyWith(
          currentBalance: newBalance,
          portfolio: newPortfolio,
          errorMessage: null,
        )));
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
        final holding =
            data.portfolio.firstWhere((p) => p.symbol == event.symbol,
                orElse: () => const PortfolioItem(
                      symbol: '',
                      quantity: 0,
                      avgPrice: 0,
                    ));

        if (holding.symbol.isEmpty || holding.quantity < event.quantity) {
          emit(StockState.data(data.copyWith(
            errorMessage: '보유 수량이 부족합니다!',
          )));
          return;
        }

        final stock = data.stocks.firstWhere((s) => s.symbol == event.symbol);
        final totalRevenue = stock.price * event.quantity;
        final newBalance = data.currentBalance + totalRevenue;

        final newPortfolio = data.portfolio
            .map((p) {
              if (p.symbol == event.symbol) {
                return PortfolioItem(
                  symbol: p.symbol,
                  quantity: p.quantity - event.quantity,
                  avgPrice: p.avgPrice,
                );
              }
              return p;
            })
            .where((p) => p.quantity > 0)
            .toList();

        emit(StockState.data(data.copyWith(
          currentBalance: newBalance,
          portfolio: newPortfolio,
          errorMessage: null,
        )));
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
          );

          if (availableEvents.isNotEmpty) {
            final selectedEvent = availableEvents.elementAt(
              _random.nextInt(availableEvents.length),
            );

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

          emit(StockState.data(data.copyWith(
            activeEvent: event.event,
            currentBalance: data.currentBalance + dividendAmount,
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

  @override
  Future<void> close() {
    _priceUpdateTimer?.cancel();
    return super.close();
  }
}
