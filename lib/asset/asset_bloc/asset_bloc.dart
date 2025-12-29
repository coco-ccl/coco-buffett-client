import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/asset_repository.dart';

part 'asset_event.dart';
part 'asset_state.dart';
part 'asset_bloc.freezed.dart';

/// 자산 BLoC - 예치금 및 자산 관리 (AssetRepository 연동)
class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository assetRepository;
  StreamSubscription? _cashSubscription;
  StreamSubscription? _stocksSubscription;

  AssetBloc({
    required this.assetRepository,
  }) : super(_initState) {
    on<_Started>(_onStarted);
    on<_DepositChanged>(_onDepositChanged);
    on<_ItemPurchased>(_onItemPurchased);
    on<_BalanceAdded>(_onBalanceAdded);
    on<_CashUpdated>(_onCashUpdated);
    on<_StocksUpdated>(_onStocksUpdated);

    // AssetRepository의 cashStream 구독
    _cashSubscription = assetRepository.cashStream.listen((cash) {
      add(AssetEvent.cashUpdated(cash));
    });

    // AssetRepository의 stocksStream 구독
    _stocksSubscription = assetRepository.stocksStream.listen((stocks) {
      add(AssetEvent.stocksUpdated(stocks));
    });
  }

  static AssetState get _initState => AssetState(
        AssetData(
          deposit: 10000, // 초기값 (곧 Repository에서 덮어씌워짐)
          stocks: [],
          totalSpent: 0,
          purchaseHistory: [],
        ),
      );

  Future<void> _onStarted(
    _Started event,
    Emitter<AssetState> emit,
  ) async {
    // Repository에서 현재 데이터 가져오기 (이미 초기화됨)
    final currentCash = assetRepository.currentCash;
    final currentStocks = assetRepository.myStocks;

    emit(AssetState(
      state.data.copyWith(
        deposit: currentCash,
        stocks: currentStocks,
      ),
    ));
  }

  Future<void> _onCashUpdated(
    _CashUpdated event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetState(
      state.data.copyWith(deposit: event.cash),
    ));
  }

  Future<void> _onStocksUpdated(
    _StocksUpdated event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetState(
      state.data.copyWith(stocks: event.stocks),
    ));
  }

  FutureOr<void> _onDepositChanged(
    _DepositChanged event,
    Emitter<AssetState> emit,
  ) async {
    // AssetRepository를 직접 업데이트하지 않음
    // 이 이벤트는 더 이상 사용하지 않는 것을 권장 (대신 AssetRepository 메서드 사용)
    emit(AssetState(state.data.copyWith(deposit: event.amount)));
  }

  FutureOr<void> _onItemPurchased(
    _ItemPurchased event,
    Emitter<AssetState> emit,
  ) async {
    if (state.data.deposit >= event.price) {
      // AssetRepository를 통해 현금 차감
      final success = await assetRepository.deductCash(event.price);

      if (success) {
        final newTotalSpent = state.data.totalSpent + event.price;
        final newHistory = [
          ...state.data.purchaseHistory,
          PurchaseRecord(
            itemName: event.itemName,
            price: event.price,
            timestamp: DateTime.now(),
          ),
        ];

        emit(AssetState(
          state.data.copyWith(
            totalSpent: newTotalSpent,
            purchaseHistory: newHistory,
          ),
        ));
      }
      // cashStream이 자동으로 deposit 업데이트
    }
  }

  FutureOr<void> _onBalanceAdded(
    _BalanceAdded event,
    Emitter<AssetState> emit,
  ) async {
    // AssetRepository를 통해 현금 추가
    await assetRepository.addCash(event.amount);
    // Stream이 자동으로 업데이트되므로 별도 emit 불필요
  }

  @override
  Future<void> close() {
    _cashSubscription?.cancel();
    _stocksSubscription?.cancel();
    return super.close();
  }
}
