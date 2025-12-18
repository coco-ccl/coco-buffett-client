import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'asset_event.dart';
part 'asset_state.dart';
part 'asset_bloc.freezed.dart';

/// 자산 BLoC - 예치금 및 자산 관리
class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc() : super(_initState) {
    on<_DepositChanged>(_onDepositChanged);
    on<_ItemPurchased>(_onItemPurchased);
    on<_BalanceAdded>(_onBalanceAdded);
  }

  static AssetState get _initState => AssetState(
        AssetData(
          deposit: 10000, // 초기 예치금 10,000원
          stocks: [
            // 더미 주식 데이터
            const Stock(
              name: 'Apple Inc.',
              ticker: 'AAPL',
              quantity: 5,
            ),
            const Stock(
              name: 'Tesla Inc.',
              ticker: 'TSLA',
              quantity: 2,
            ),
            const Stock(
              name: 'Microsoft Corporation',
              ticker: 'MSFT',
              quantity: 3,
            ),
          ],
          totalSpent: 0,
          purchaseHistory: [],
        ),
      );

  FutureOr<void> _onDepositChanged(
    _DepositChanged event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetState(state.data.copyWith(deposit: event.amount)));
  }

  FutureOr<void> _onItemPurchased(
    _ItemPurchased event,
    Emitter<AssetState> emit,
  ) async {
    if (state.data.deposit >= event.price) {
      final newDeposit = state.data.deposit - event.price;
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
          deposit: newDeposit,
          totalSpent: newTotalSpent,
          purchaseHistory: newHistory,
        ),
      ));
    }
  }

  FutureOr<void> _onBalanceAdded(
    _BalanceAdded event,
    Emitter<AssetState> emit,
  ) async {
    final newDeposit = state.data.deposit + event.amount;
    emit(AssetState(state.data.copyWith(deposit: newDeposit)));
  }
}
