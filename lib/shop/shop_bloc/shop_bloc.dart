import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/asset_repository.dart';
import '../../data/repositories/item_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';
part 'shop_bloc.freezed.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final AssetRepository assetRepository;
  final ItemRepository itemRepository;
  StreamSubscription? _cashSubscription;
  StreamSubscription? _ownedItemsSubscription;

  ShopBloc({
    required this.assetRepository,
    required this.itemRepository,
  }) : super(const ShopState.initial()) {
    on<_Started>(_onStarted);
    on<_PurchaseItem>(_onPurchaseItem);
    on<_ClearError>(_onClearError);
    on<_CashUpdated>(_onCashUpdated);
    on<_OwnedItemsUpdated>(_onOwnedItemsUpdated);

    // AssetRepository의 cashStream 구독
    _cashSubscription = assetRepository.cashStream.listen((cash) {
      add(ShopEvent.cashUpdated(cash));
    });

    // ItemRepository의 ownedItemsStream 구독
    _ownedItemsSubscription = itemRepository.ownedItemsStream.listen((items) {
      add(ShopEvent.ownedItemsUpdated(items));
    });
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ShopState> emit,
  ) async {
    emit(const ShopState.loading());

    try {
      // 현재 상태 가져오기 (Repository는 이미 초기화됨)
      final currentCash = assetRepository.currentCash;
      final ownedItems = itemRepository.ownedItems;
      final allItems = itemRepository.allItems;

      emit(ShopState.loaded(
        currentCash: currentCash,
        ownedItems: ownedItems,
        allItems: allItems,
      ));
    } catch (e) {
      emit(ShopState.error(e.toString()));
    }
  }

  Future<void> _onPurchaseItem(
    _PurchaseItem event,
    Emitter<ShopState> emit,
  ) async {
    await state.maybeWhen(
      loaded: (currentCash, ownedItems, allItems, _) async {
        try {
          // 1. 아이템 정보 조회
          final item = allItems.firstWhere(
            (i) => i.itemId == event.itemId,
            orElse: () => throw Exception('아이템을 찾을 수 없습니다'),
          );

          // 2. 이미 보유한 아이템인지 확인
          if (ownedItems.any((i) => i.itemId == event.itemId)) {
            emit(ShopState.loaded(
              currentCash: currentCash,
              ownedItems: ownedItems,
              allItems: allItems,
              errorMessage: '이미 보유한 아이템입니다!',
            ));
            return;
          }

          // 3. 현금 확인
          if (item.price > currentCash) {
            emit(ShopState.loaded(
              currentCash: currentCash,
              ownedItems: ownedItems,
              allItems: allItems,
              errorMessage: '잔고가 부족합니다!',
            ));
            return;
          }

          // 4. 현금 차감
          final cashDeducted = await assetRepository.deductCash(item.price);
          if (!cashDeducted) {
            emit(ShopState.loaded(
              currentCash: currentCash,
              ownedItems: ownedItems,
              allItems: allItems,
              errorMessage: '잔고가 부족합니다!',
            ));
            return;
          }

          // 5. 아이템 추가
          await itemRepository.purchaseItemWithCache(event.itemId);

          // Stream이 자동으로 업데이트하므로 별도 emit 불필요
        } catch (e) {
          emit(ShopState.loaded(
            currentCash: currentCash,
            ownedItems: ownedItems,
            allItems: allItems,
            errorMessage: e.toString(),
          ));
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onClearError(
    _ClearError event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.maybeWhen(
      loaded: (currentCash, ownedItems, allItems, _) => ShopState.loaded(
        currentCash: currentCash,
        ownedItems: ownedItems,
        allItems: allItems,
        errorMessage: null,
      ),
      orElse: () => state,
    ));
  }

  Future<void> _onCashUpdated(
    _CashUpdated event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.maybeWhen(
      loaded: (_, ownedItems, allItems, errorMessage) => ShopState.loaded(
        currentCash: event.cash,
        ownedItems: ownedItems,
        allItems: allItems,
        errorMessage: errorMessage,
      ),
      orElse: () => state,
    ));
  }

  Future<void> _onOwnedItemsUpdated(
    _OwnedItemsUpdated event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.maybeWhen(
      loaded: (currentCash, _, allItems, errorMessage) => ShopState.loaded(
        currentCash: currentCash,
        ownedItems: event.items,
        allItems: allItems,
        errorMessage: errorMessage,
      ),
      orElse: () => state,
    ));
  }

  @override
  Future<void> close() {
    _cashSubscription?.cancel();
    _ownedItemsSubscription?.cancel();
    return super.close();
  }
}
