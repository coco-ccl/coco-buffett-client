import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/stock_model.dart';
import '../models/portfolio_model.dart';
import '../data/initial_stocks.dart';
import '../../data/repositories/asset_repository.dart';
import '../../data/repositories/stock_repository.dart' as repo;
import '../../asset/asset_bloc/asset_bloc.dart' as asset;

part 'stock_event.dart';
part 'stock_state.dart';
part 'stock_bloc.freezed.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final AssetRepository? assetRepository;
  final repo.StockRepository? stockRepository;
  StreamSubscription? _cashSubscription;
  StreamSubscription? _stocksSubscription;
  StreamSubscription? _portfolioSubscription;

  // 이전 가격 저장 (등락율 계산용)
  final Map<String, double> _previousPrices = {};

  StockBloc({this.assetRepository, this.stockRepository}) : super(_initState) {
    on<_Started>(_onStarted);
    on<_BuyStock>(_onBuyStock);
    on<_SellStock>(_onSellStock);
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
        // TradableStock을 Stock 모델로 변환 (등락율 계산 포함)
        final updatedStocks = tradableStocks.map((ts) {
          final currentPrice = ts.currentPrice.toDouble();
          final previousPrice = _previousPrices[ts.ticker];

          // 등락율 계산: ((현재가 - 이전가) / 이전가) * 100
          final change = previousPrice != null
              ? ((currentPrice - previousPrice) / previousPrice) * 100
              : 0.0;

          // 현재 가격을 다음 비교를 위해 저장
          _previousPrices[ts.ticker] = currentPrice;

          return Stock(
            symbol: ts.ticker,
            name: ts.name,
            price: currentPrice,
            change: change,
            volume: 1000000,
          );
        }).toList();

        // Event로 전달
        add(StockEvent.stocksUpdated(updatedStocks));
      });
    }
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
    // StockRepository 초기화
    if (stockRepository != null) {
      await stockRepository!.initialize();
    }

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

        if (stockRepository == null || assetRepository == null) {
          emit(StockState.data(data.copyWith(
            errorMessage: 'Repository가 설정되지 않았습니다!',
          )));
          return;
        }

        try {
          // 1. 서버에 매수 요청 (StockRepository)
          await stockRepository!.buyStock(
            ticker: event.symbol,
            quantity: event.quantity,
            price: stock.price.toInt(),
          );

          // 2. 자산 정보 재조회 (서버에서 최신 정보 가져옴)
          await assetRepository!.refresh();

          // stocksStream이 portfolio를 자동 업데이트
        } catch (e) {
          emit(StockState.data(data.copyWith(
            errorMessage: e.toString().contains('잔고')
              ? '잔고가 부족합니다!'
              : '매수 실패: ${e.toString()}',
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

        if (stockRepository == null || assetRepository == null) {
          emit(StockState.data(data.copyWith(
            errorMessage: 'Repository가 설정되지 않았습니다!',
          )));
          return;
        }

        try {
          // 1. 서버에 매도 요청 (StockRepository)
          await stockRepository!.sellStock(
            ticker: event.symbol,
            quantity: event.quantity,
            price: stock.price.toInt(),
          );

          // 2. 자산 정보 재조회 (서버에서 최신 정보 가져옴)
          await assetRepository!.refresh();

          // stocksStream이 portfolio를 자동 업데이트
        } catch (e) {
          emit(StockState.data(data.copyWith(
            errorMessage: e.toString().contains('수량')
              ? '보유 수량이 부족합니다!'
              : '매도 실패: ${e.toString()}',
          )));
        }
      },
      orElse: () {},
    );
  }


  Future<void> _onStocksUpdated(
    _StocksUpdated event,
    Emitter<StockState> emit,
  ) async {
    emit(state.maybeWhen(
      data: (data) {
        // 가격 히스토리 업데이트
        final newPriceHistory = Map<String, List<PriceHistory>>.from(data.priceHistory);
        for (final stock in event.stocks) {
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

        return StockState.data(data.copyWith(
          stocks: event.stocks,
          priceHistory: newPriceHistory,
        ));
      },
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
    _cashSubscription?.cancel();
    _stocksSubscription?.cancel();
    _portfolioSubscription?.cancel();
    return super.close();
  }
}
