part of 'shop_bloc.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial() = _Initial;
  const factory ShopState.loading() = _Loading;
  const factory ShopState.loaded({
    required int currentCash,
    required List<GameItem> ownedItems,
    required List<GameItem> allItems,
    String? errorMessage,
  }) = _Loaded;
  const factory ShopState.error(String message) = _Error;
}
