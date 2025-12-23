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
        _useMockData = useMockData {
    print('[ItemRepository] 생성됨 - useMockData: $_useMockData');
  }

  /// 아이템 리스트 조회 (캐시 업데이트 포함)
  Future<List<GameItem>> getItems() async {
    print('[ItemRepository] 아이템 리스트 조회 시작');

    List<GameItem> items;

    if (_useMockData) {
      print('[ItemRepository] Mock 데이터 반환');
      items = _getMockItems();
    } else {
      final response = await _apiClient.getItems();
      if (response.code == 0 && response.data != null) {
        items = response.data!
            .map((dto) => _convertToGameItem(dto))
            .toList();
        print('[ItemRepository] 아이템 ${items.length}개 조회 성공');
      } else {
        print('[ItemRepository] 아이템 조회 실패: ${response.message}');
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
    print('[ItemRepository] 착용 아이템 조회 시작');

    if (_useMockData) {
      print('[ItemRepository] Mock 착용 아이템 반환');
      return _getMockEquippedItems();
    }

    final response = await _apiClient.getEquippedItems();
    if (response.code == 0 && response.data != null) {
      final items = response.data!
          .map((dto) => _convertToEquippedItem(dto))
          .toList();
      print('[ItemRepository] 착용 아이템 ${items.length}개 조회 성공');
      return items;
    }

    print('[ItemRepository] 착용 아이템 조회 실패: ${response.message}');
    throw Exception('Failed to load equipped items');
  }

  /// 아이템 구매 (Public API)
  Future<int> purchaseItem(String itemId) async {
    print('[ItemRepository] 아이템 구매 시작: itemId=$itemId');

    if (_useMockData) {
      // Mock 모드: 임의의 잔여 예치금 반환
      await Future.delayed(const Duration(milliseconds: 500));
      print('[ItemRepository] 아이템 구매 성공 (Mock): 잔여금=85000');
      return 85000; // Mock 잔여 예치금
    }

    final response = await _apiClient.purchaseItem(itemId);
    if (response.code == 0 && response.data != null) {
      final remaining = response.data!.remainingDeposit;
      print('[ItemRepository] 아이템 구매 성공: 잔여금=$remaining');
      return remaining;
    }

    print('[ItemRepository] 아이템 구매 실패: ${response.message}');
    throw Exception(response.message);
  }

  /// 아이템 착용
  Future<void> equipItem(String itemId) async {
    print('[ItemRepository] 아이템 착용 시작: itemId=$itemId');

    if (_useMockData) {
      // Mock 모드: 딜레이만 추가
      await Future.delayed(const Duration(milliseconds: 300));
      print('[ItemRepository] 아이템 착용 성공 (Mock)');
      return;
    }

    final response = await _apiClient.equipItem(itemId);
    if (response.code == 0) {
      print('[ItemRepository] 아이템 착용 성공');
      return;
    }

    print('[ItemRepository] 아이템 착용 실패: ${response.message}');
    throw Exception(response.message);
  }

  /// 아이템 구매 (캐시 업데이트 포함)
  Future<bool> purchaseItemWithCache(String itemId) async {
    // 이미 보유한 아이템인지 확인
    if (_ownedItems.any((item) => item.itemId == itemId)) {
      return false;
    }

    // 전체 아이템에서 찾기
    final item = _allItems.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => throw Exception('Item not found'),
    );

    // API 호출 (itemId를 int로 변환 필요 - 임시로 price 사용하거나 별도 처리 필요)
    // TODO: API가 itemId를 String으로 받도록 수정 필요
    // await _purchaseItemAPI(itemId);

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
      name: response.name ?? _getDefaultName(response.itemId),
      price: response.price,
      color: response.color,
      isOwned: response.isOwned ?? true, // owned API는 보유 중인 아이템만 반환
    );
  }

  /// itemId로 기본 이름 생성
  String _getDefaultName(String itemId) {
    // itemId를 기반으로 한글 이름 생성
    final nameMap = {
      'default': '기본',
      'cute': '귀여움',
      'cool': '멋짐',
      'short_brown': '짧은 갈색',
      'short_black': '짧은 검정',
      'short_blonde': '짧은 금발',
      'long_brown': '긴 갈색',
      'long_black': '긴 검정',
      'pomade_black': '포마드 검정',
      'pomade_brown': '포마드 갈색',
      'gray': '회색',
      'tshirt_white': '흰색 티셔츠',
      'tshirt_blue': '파란 티셔츠',
      'tshirt_red': '빨간 티셔츠',
      'tshirt_green': '초록 티셔츠',
      'tshirt_flower': '꽃무늬 티셔츠',
      'shirt_white': '흰색 셔츠',
      'pants_black': '검정 바지',
      'pants_navy': '네이비 바지',
      'pants_gray': '회색 바지',
      'jeans_blue': '파란 청바지',
      'shoes_black': '검정 구두',
      'shoes_brown': '갈색 구두',
      'sneakers_white': '흰색 운동화',
      'sneakers_black': '검정 운동화',
    };
    return nameMap[itemId] ?? itemId;
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
      GameItem(itemId: 'default', type: 'face', name: '기본', color: 'default', price: 0, isOwned: true),
      GameItem(itemId: 'cute', type: 'face', name: '귀여움', color: 'pink', price: 100, isOwned: false),
      GameItem(itemId: 'cool', type: 'face', name: '멋짐', color: 'blue', price: 100, isOwned: false),

      // 머리 (hair)
      GameItem(itemId: 'short_brown', type: 'hair', name: '짧은 갈색', color: 'brown', price: 0, isOwned: true),
      GameItem(itemId: 'short_black', type: 'hair', name: '짧은 검정', color: 'black', price: 150, isOwned: false),
      GameItem(itemId: 'short_blonde', type: 'hair', name: '짧은 금발', color: 'blonde', price: 150, isOwned: false),
      GameItem(itemId: 'long_brown', type: 'hair', name: '긴 갈색', color: 'brown', price: 200, isOwned: false),
      GameItem(itemId: 'long_black', type: 'hair', name: '긴 검정', color: 'black', price: 200, isOwned: false),
      GameItem(itemId: 'pomade_black', type: 'hair', name: '포마드 검정', color: 'black', price: 250, isOwned: false),
      GameItem(itemId: 'pomade_brown', type: 'hair', name: '포마드 갈색', color: 'brown', price: 250, isOwned: false),
      GameItem(itemId: 'gray', type: 'hair', name: '회색', color: 'gray', price: 300, isOwned: false),

      // 상의 (top)
      GameItem(itemId: 'tshirt_white', type: 'top', name: '흰색 티셔츠', color: 'white', price: 0, isOwned: true),
      GameItem(itemId: 'tshirt_blue', type: 'top', name: '파란 티셔츠', color: 'blue', price: 100, isOwned: false),
      GameItem(itemId: 'tshirt_red', type: 'top', name: '빨간 티셔츠', color: 'red', price: 100, isOwned: false),
      GameItem(itemId: 'tshirt_green', type: 'top', name: '초록 티셔츠', color: 'green', price: 100, isOwned: false),
      GameItem(itemId: 'tshirt_flower', type: 'top', name: '꽃무늬 티셔츠', color: 'flower', price: 200, isOwned: false),
      GameItem(itemId: 'shirt_white', type: 'top', name: '흰색 셔츠', color: 'white', price: 250, isOwned: false),

      // 하의 (bottom)
      GameItem(itemId: 'pants_black', type: 'bottom', name: '검정 바지', color: 'black', price: 0, isOwned: true),
      GameItem(itemId: 'pants_navy', type: 'bottom', name: '네이비 바지', color: 'navy', price: 150, isOwned: false),
      GameItem(itemId: 'pants_gray', type: 'bottom', name: '회색 바지', color: 'gray', price: 150, isOwned: false),
      GameItem(itemId: 'jeans_blue', type: 'bottom', name: '파란 청바지', color: 'blue', price: 200, isOwned: false),

      // 신발 (shoes)
      GameItem(itemId: 'shoes_black', type: 'shoes', name: '검정 구두', color: 'black', price: 0, isOwned: true),
      GameItem(itemId: 'shoes_brown', type: 'shoes', name: '갈색 구두', color: 'brown', price: 150, isOwned: false),
      GameItem(itemId: 'sneakers_white', type: 'shoes', name: '흰색 운동화', color: 'white', price: 200, isOwned: false),
      GameItem(itemId: 'sneakers_black', type: 'shoes', name: '검정 운동화', color: 'black', price: 200, isOwned: false),
    ];
  }

  /// Mock 데이터 반환 - 보유한 아이템만
  List<GameItem> _getMockOwnedItems() {
    return _getMockItems().where((item) => item.isOwned).toList();
  }

  /// Mock 데이터 반환 - 착용한 아이템
  List<EquippedItem> _getMockEquippedItems() {
    return const [
      EquippedItem(itemId: 'default', type: 'face', color: 'default'),
      EquippedItem(itemId: 'short_brown', type: 'hair', color: 'brown'),
      EquippedItem(itemId: 'tshirt_white', type: 'top', color: 'white'),
      EquippedItem(itemId: 'pants_black', type: 'bottom', color: 'black'),
      EquippedItem(itemId: 'shoes_black', type: 'shoes', color: 'black'),
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
  final String itemId; // 스프라이트 ID (예: "cool", "cute", "default")
  final String type; // face, hair, top, bottom, shoes
  final String name; // 한글 이름 (예: "멋짐", "귀여움")
  final int price; // 가격 (원)
  final String color; // 색상 메타데이터 (예: "blue", "pink")
  final bool isOwned; // 보유 여부

  const GameItem({
    required this.itemId,
    required this.type,
    required this.name,
    required this.price,
    required this.color,
    required this.isOwned,
  });

  /// copyWith 메서드
  GameItem copyWith({
    String? itemId,
    String? type,
    String? name,
    String? color,
    int? price,
    bool? isOwned,
  }) {
    return GameItem(
      itemId: itemId ?? this.itemId,
      type: type ?? this.type,
      name: name ?? this.name,
      color: color ?? this.color,
      price: price ?? this.price,
      isOwned: isOwned ?? this.isOwned,
    );
  }
}

/// 착용 아이템 도메인 모델
class EquippedItem {
  final String itemId; // 스프라이트 ID
  final String type; // face, hair, top, bottom, shoes
  final String color;

  const EquippedItem({
    required this.itemId,
    required this.type,
    required this.color,
  });
}
