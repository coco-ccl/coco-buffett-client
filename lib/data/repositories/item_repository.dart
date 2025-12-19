import '../api/api_client.dart';
import '../models/item_response.dart';
import '../models/equipped_item_response.dart';

/// Item Repository - 아이템 데이터 관리
class ItemRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  ItemRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 아이템 리스트 조회
  Future<List<GameItem>> getItems() async {
    if (_useMockData) {
      return _getMockItems();
    }

    final response = await _apiClient.getItems();
    if (response.code == 0 && response.data != null) {
      return response.data!
          .map((dto) => _convertToGameItem(dto))
          .toList();
    }

    throw Exception('Failed to load items');
  }

  /// 내가 보유한 아이템 조회
  Future<List<GameItem>> getOwnedItems() async {
    if (_useMockData) {
      return _getMockOwnedItems();
    }

    final response = await _apiClient.getOwnedItems();
    if (response.code == 0 && response.data != null) {
      return response.data!
          .map((dto) => _convertToGameItem(dto))
          .toList();
    }

    throw Exception('Failed to load owned items');
  }

  /// 현재 착용한 아이템 조회
  Future<List<EquippedItem>> getEquippedItems() async {
    if (_useMockData) {
      return _getMockEquippedItems();
    }

    final response = await _apiClient.getEquippedItems();
    if (response.code == 0 && response.data != null) {
      return response.data!
          .map((dto) => _convertToEquippedItem(dto))
          .toList();
    }

    throw Exception('Failed to load equipped items');
  }

  /// 아이템 구매
  Future<int> purchaseItem(int itemId) async {
    if (_useMockData) {
      // Mock 모드: 임의의 잔여 예치금 반환
      await Future.delayed(const Duration(milliseconds: 500));
      return 85000; // Mock 잔여 예치금
    }

    final response = await _apiClient.purchaseItem(itemId);
    if (response.code == 0 && response.data != null) {
      return response.data!.remainingDeposit;
    }

    throw Exception(response.message);
  }

  /// DTO를 도메인 모델로 변환
  GameItem _convertToGameItem(ItemResponse response) {
    return GameItem(
      itemId: response.itemId,
      type: response.type,
      color: response.color,
      price: response.price,
      isOwned: response.isOwned,
    );
  }

  /// EquippedItemResponse를 EquippedItem으로 변환
  EquippedItem _convertToEquippedItem(EquippedItemResponse response) {
    return EquippedItem(
      itemId: response.itemId,
      type: response.type,
      color: response.color,
    );
  }

  /// Mock 데이터 반환 - 전체 아이템
  List<GameItem> _getMockItems() {
    return const [
      // 얼굴 (face)
      GameItem(itemId: 1, type: 'face', color: 'default', price: 0, isOwned: true),
      GameItem(itemId: 2, type: 'face', color: 'happy', price: 500, isOwned: false),

      // 머리 (hair)
      GameItem(itemId: 10, type: 'hair', color: 'black', price: 0, isOwned: true),
      GameItem(itemId: 11, type: 'hair', color: 'brown', price: 300, isOwned: false),
      GameItem(itemId: 12, type: 'hair', color: 'blonde', price: 300, isOwned: false),

      // 상의 (top)
      GameItem(itemId: 20, type: 'top', color: 'white', price: 0, isOwned: true),
      GameItem(itemId: 21, type: 'top', color: 'green', price: 500, isOwned: false),
      GameItem(itemId: 22, type: 'top', color: 'blue', price: 500, isOwned: false),
      GameItem(itemId: 23, type: 'top', color: 'red', price: 800, isOwned: false),

      // 하의 (bottom)
      GameItem(itemId: 30, type: 'bottom', color: 'blue', price: 0, isOwned: true),
      GameItem(itemId: 31, type: 'bottom', color: 'black', price: 800, isOwned: false),
      GameItem(itemId: 32, type: 'bottom', color: 'gray', price: 600, isOwned: false),

      // 신발 (shoes)
      GameItem(itemId: 40, type: 'shoes', color: 'white', price: 0, isOwned: true),
      GameItem(itemId: 41, type: 'shoes', color: 'black', price: 400, isOwned: false),
      GameItem(itemId: 42, type: 'shoes', color: 'red', price: 600, isOwned: false),
    ];
  }

  /// Mock 데이터 반환 - 보유한 아이템만
  List<GameItem> _getMockOwnedItems() {
    return _getMockItems().where((item) => item.isOwned).toList();
  }

  /// Mock 데이터 반환 - 착용한 아이템
  List<EquippedItem> _getMockEquippedItems() {
    return const [
      EquippedItem(itemId: 1, type: 'face', color: 'default'),
      EquippedItem(itemId: 10, type: 'hair', color: 'black'),
      EquippedItem(itemId: 20, type: 'top', color: 'white'),
      EquippedItem(itemId: 30, type: 'bottom', color: 'blue'),
      EquippedItem(itemId: 40, type: 'shoes', color: 'white'),
    ];
  }
}

/// 게임 아이템 도메인 모델
class GameItem {
  final int itemId;
  final String type; // face, hair, top, bottom, shoes
  final String color;
  final int price; // 가격 (원)
  final bool isOwned; // 보유 여부

  const GameItem({
    required this.itemId,
    required this.type,
    required this.color,
    required this.price,
    required this.isOwned,
  });
}

/// 착용 아이템 도메인 모델
class EquippedItem {
  final int itemId;
  final String type; // face, hair, top, bottom, shoes
  final String color;

  const EquippedItem({
    required this.itemId,
    required this.type,
    required this.color,
  });
}
