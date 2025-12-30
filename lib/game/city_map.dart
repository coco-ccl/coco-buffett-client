import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'buildings/building.dart';
import 'buildings/empire_building.dart';
import 'buildings/hotel_building.dart';
import 'buildings/department_store.dart' show DepartmentStore, DepartmentColorPresets, DepartmentStoreDoor;
import 'buildings/stock_exchange.dart' show StockExchange, StockExchangeColorPresets, StockExchangeDoor;
import 'buildings/gangnam_tower.dart';
import 'buildings/apartment_building.dart';
import 'components/sky_background.dart';
import 'components/celestial_body.dart';
import 'components/pixel_clouds.dart';
import 'components/road_layer.dart';

class CityMap extends PositionComponent with HasGameReference {
  final List<Building> _buildings = [];
  DepartmentStore? _departmentStore;
  StockExchange? _stockExchange;
  RoadLayer? _sidewalkLayer;
  RoadLayer? _asphaltLayer;
  late double _groundY;

  static const double buildingScale = 1.5;

  // 캐릭터 스폰 지점 (인도 위)
  Vector2 get spawnPoint => Vector2(500, _groundY + 10);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // 맵 높이 설정 - 카메라 앵커가 0.7이므로 화면의 위쪽 70%가 하늘, 아래쪽 30%가 땅/길
    // 맵을 충분히 크게 만들어서 카메라가 어디를 비춰도 맵 바깥이 안 보이도록
    final mapHeight = game.size.y * 2;
    size = Vector2(4500, mapHeight);

    // 1. 환경 레이어 추가 (배경은 맵 전체 크기로)
    await add(SkyBackground(mapWidth: size.x, mapHeight: size.y));
    await add(CelestialBody());
    await add(PixelClouds());

    // 2. 타일 기반 길 추가 (맵 중앙쯤에 배치 - 카메라가 플레이어를 하단에 놓으므로)
    _groundY = size.y * 0.5; // 맵 중앙

    // 인도 (Sidewalk)
    _sidewalkLayer = RoadLayer(
      position: Vector2(0, _groundY),
      size: Vector2(size.x, 40),
      style: RoadTileStyle.sidewalk,
    );
    await add(_sidewalkLayer!);

    // 차도 (Asphalt)
    _asphaltLayer = RoadLayer(
      position: Vector2(0, _groundY + 40),
      size: Vector2(size.x, 180),
      style: RoadTileStyle.asphalt,
    );
    await add(_asphaltLayer!);

    // 빌딩 배치 시작 위치
    double currentX = 150.0;
    const double gap = 120.0;

    Future<void> addBuilding(Building b) async {
      await add(b);
      _buildings.add(b);
      currentX += b.size.x + gap;
    }

    // --- 빌딩군 배치 ---
    await addBuilding(EmpireBuilding(
      position: Vector2(currentX, _groundY),
      width: 70,
      height: 320,
      buildingScale: buildingScale,
      colorSet: EmpireColorPresets.midnightBlue,
    ));

    await addBuilding(ApartmentBuilding(
      position: Vector2(currentX, _groundY),
      width: 60,
      height: 240,
      floors: 7,
      unitsPerFloor: 2,
      buildingScale: buildingScale,
      colorSet: ApartmentColorPresets.brickRed,
    ));

    await addBuilding(HotelBuilding(
      position: Vector2(currentX, _groundY),
      width: 90,
      height: 180,
      buildingScale: buildingScale,
      colorSet: HotelColorPresets.boutiquePurple,
    ));

    _departmentStore = DepartmentStore(
      position: Vector2(currentX + 50, _groundY),
      width: 280,
      height: 240,
      buildingScale: buildingScale,
      colorSet: DepartmentColorPresets.classicShinsegae,
    );
    await addBuilding(_departmentStore!);
    currentX += 50;

    // DepartmentStore 문 영역 추가 (별도 컴포넌트로)
    await add(DepartmentStoreDoor(
      position: _departmentStore!.getDoorPosition(),
      size: _departmentStore!.getDoorSize(),
    ));

    _stockExchange = StockExchange(
      position: Vector2(currentX + 50, _groundY),
      width: 320,
      height: 280,
      buildingScale: buildingScale,
      colorSet: StockExchangeColorPresets.classicNYSE,
    );
    await addBuilding(_stockExchange!);
    currentX += 50;

    // StockExchange 문 영역 추가 (별도 컴포넌트로)
    await add(StockExchangeDoor(
      position: _stockExchange!.getDoorPosition(),
      size: _stockExchange!.getDoorSize(),
    ));

    await addBuilding(GangnamTower(
      position: Vector2(currentX, _groundY),
      width: 100,
      height: 380,
      buildingScale: buildingScale,
      colorSet: GangnamColorPresets.cyberCyan,
    ));

    await addBuilding(ApartmentBuilding(
      position: Vector2(currentX, _groundY),
      width: 70,
      height: 160,
      floors: 5,
      unitsPerFloor: 3,
      buildingScale: buildingScale,
      colorSet: ApartmentColorPresets.luxuryBeige,
    ));

    await addBuilding(GangnamTower(
      position: Vector2(currentX, _groundY),
      width: 90,
      height: 340,
      buildingScale: buildingScale,
      colorSet: GangnamColorPresets.emeraldGreen,
    ));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // CityMap의 높이를 화면의 2배로 업데이트
    final mapHeight = size.y * 2;
    this.size = Vector2(4500, mapHeight);
    _groundY = mapHeight * 0.5; // 맵 중앙

    // RoadLayer들의 위치와 크기 업데이트
    _sidewalkLayer?.position = Vector2(0, _groundY);
    _sidewalkLayer?.size = Vector2(this.size.x, 40);
    _asphaltLayer?.position = Vector2(0, _groundY + 40);
    _asphaltLayer?.size = Vector2(this.size.x, 180);
  }

  @override
  void render(Canvas canvas) {
    // 도로는 이제 컴포넌트로 처리되므로 직접 그리지 않음
    super.render(canvas);
  }

  bool isBlocked(Rect rect) {
    for (var b in _buildings) {
      // 건물 바닥만 막고, 중앙 문 영역은 열어둠
      final centerX = b.position.x + b.size.x / 2;
      final doorWidth = 100 * buildingScale; // 문 영역 너비

      // 왼쪽 바닥 영역
      final leftFloorRect = Rect.fromLTWH(
        b.position.x,
        b.position.y - 30,
        (b.size.x / 2) - (doorWidth / 2),
        30,
      );
      if (leftFloorRect.overlaps(rect)) return true;

      // 오른쪽 바닥 영역
      final rightFloorRect = Rect.fromLTWH(
        centerX + (doorWidth / 2),
        b.position.y - 30,
        (b.size.x / 2) - (doorWidth / 2),
        30,
      );
      if (rightFloorRect.overlaps(rect)) return true;
    }
    // 인도 위쪽으로는 이동 불가 (건물 앞까지만)
    if (rect.top < _groundY - 50) return true;
    // 차도 아래로는 이동 불가
    if (rect.bottom > _groundY + 220) return true;
    return false;
  }
}
