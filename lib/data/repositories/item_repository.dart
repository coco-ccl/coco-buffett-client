import 'dart:async';
import '../api/api_client.dart';
import '../models/item_response.dart';
import '../models/equipped_item_response.dart';

/// Item Repository - 아이템 데이터 관리 (Stream 기반 캐싱 포함)
class ItemRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  // Private 캐시 변수
  List<GameItem> _allItems = [];
  List<GameItem> _ownedItems = [];

  // StreamController
  final _ownedItemsController = StreamController<List<GameItem>>.broadcast();

  // Public Streams
  Stream<List<GameItem>> get ownedItemsStream => _ownedItemsController.stream;

  // Current values (Synchronous access)
  List<GameItem> get ownedItems => List.unmodifiable(_ownedItems);
  List<GameItem> get allItems => List.unmodifiable(_allItems);

  ItemRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 아이템 리스트 조회 (캐시 업데이트 포함)
  Future<List<GameItem>> getItems() async {
    List<GameItem> items;

    if (_useMockData) {
      items = _getMockItems();
    } else {
      final response = await _apiClient.getItems();
      if (response.code == 0 && response.data != null) {
        items = response.data!
            .map((dto) => _convertToGameItem(dto))
            .toList();
      } else {
        throw Exception('Failed to load items');
      }
    }

    // 캐시 업데이트
    _allItems = items;

    return items;
  }

  /// 내가 보유한 아이템 조회 (캐시 업데이트 포함)
  Future<List<GameItem>> getOwnedItems() async {
    List<GameItem> items;

    if (_useMockData) {
      items = _getMockOwnedItems();
    } else {
      final response = await _apiClient.getOwnedItems();
      if (response.code == 0 && response.data != null) {
        items = response.data!
            .map((dto) => _convertToGameItem(dto))
            .toList();
      } else {
        throw Exception('Failed to load owned items');
      }
    }

    // 캐시 업데이트 및 Stream emit
    _ownedItems = items;
    _ownedItemsController.add(List.from(_ownedItems));

    return items;
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

  /// 아이템 구매 (API 호출만)
  Future<int> _purchaseItemAPI(int itemId) async {
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

  /// 아이템 구매 (캐시 업데이트 포함)
  Future<bool> purchaseItemWithCache(int itemId) async {
    // 이미 보유한 아이템인지 확인
    if (_ownedItems.any((item) => item.itemId == itemId)) {
      return false;
    }

    // 전체 아이템에서 찾기
    final item = _allItems.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => throw Exception('Item not found'),
    );

    // API 호출
    await _purchaseItemAPI(itemId);

    // 캐시 업데이트
    _ownedItems.add(item.copyWith(isOwned: true));
    _ownedItemsController.add(List.from(_ownedItems));

    return true;
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

  /// 초기화 (서버에서 데이터 로드 후 캐시 설정)
  Future<void> initialize() async {
    // getItems()가 _allItems를 업데이트함
    await getItems();

    // allItems에서 보유한 아이템만 필터링
    _ownedItems = _allItems.where((item) => item.isOwned).toList();

    // 초기값 emit
    _ownedItemsController.add(List.from(_ownedItems));
  }

  /// 리소스 정리
  void dispose() {
    _ownedItemsController.close();
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

  /// copyWith 메서드
  GameItem copyWith({
    int? itemId,
    String? type,
    String? color,
    int? price,
    bool? isOwned,
  }) {
    return GameItem(
      itemId: itemId ?? this.itemId,
      type: type ?? this.type,
      color: color ?? this.color,
      price: price ?? this.price,
      isOwned: isOwned ?? this.isOwned,
    );
  }
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
