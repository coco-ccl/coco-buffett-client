import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'buildings/building.dart';
import 'buildings/empire_building.dart';
import 'buildings/hotel_building.dart';
import 'buildings/department_store.dart' show DepartmentStore, DepartmentColorPresets, DepartmentStoreDoor;
import 'buildings/gangnam_tower.dart';
import 'buildings/apartment_building.dart';
import 'components/sky_background.dart';
import 'components/celestial_body.dart';
import 'components/pixel_clouds.dart';
import 'components/road_layer.dart';

class CityMap extends PositionComponent with HasGameReference {
  final List<Building> _buildings = [];
  DepartmentStore? _departmentStore;

  static const double buildingScale = 1.5;

  // 캐릭터 스폰 지점
  Vector2 get spawnPoint => Vector2(500, 630);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(4500, game.size.y); 

    // 1. 환경 레이어 추가
    await add(SkyBackground());
    await add(CelestialBody());
    await add(PixelClouds());

    // 2. 타일 기반 길 추가 (인도 및 차도)
    // 인도 (Sidewalk)
    await add(RoadLayer(
      position: Vector2(0, 620),
      size: Vector2(size.x, 40),
      style: RoadTileStyle.sidewalk,
    ));
    // 차도 (Asphalt)
    await add(RoadLayer(
      position: Vector2(0, 660),
      size: Vector2(size.x, 180),
      style: RoadTileStyle.asphalt,
    ));

    const double groundY = 620.0; 
    double currentX = 150.0;
    const double gap = 120.0;

    Future<void> addBuilding(Building b) async {
      await add(b);
      _buildings.add(b);
      currentX += b.size.x + gap;
    }

    // --- 빌딩군 배치 ---
    await addBuilding(EmpireBuilding(
      position: Vector2(currentX, groundY),
      width: 70,
      height: 320,
      buildingScale: buildingScale,
      colorSet: EmpireColorPresets.midnightBlue,
    ));

    await addBuilding(ApartmentBuilding(
      position: Vector2(currentX, groundY),
      width: 60,
      height: 240,
      floors: 7,
      unitsPerFloor: 2,
      buildingScale: buildingScale,
      colorSet: ApartmentColorPresets.brickRed,
    ));

    await addBuilding(HotelBuilding(
      position: Vector2(currentX, groundY),
      width: 90,
      height: 180,
      buildingScale: buildingScale,
      colorSet: HotelColorPresets.boutiquePurple,
    ));

    _departmentStore = DepartmentStore(
      position: Vector2(currentX + 50, groundY),
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

    await addBuilding(GangnamTower(
      position: Vector2(currentX, groundY),
      width: 100,
      height: 380,
      buildingScale: buildingScale,
      colorSet: GangnamColorPresets.cyberCyan,
    ));

    await addBuilding(ApartmentBuilding(
      position: Vector2(currentX, groundY),
      width: 70,
      height: 160,
      floors: 5,
      unitsPerFloor: 3,
      buildingScale: buildingScale,
      colorSet: ApartmentColorPresets.luxuryBeige,
    ));

    await addBuilding(GangnamTower(
      position: Vector2(currentX, groundY),
      width: 90,
      height: 340,
      buildingScale: buildingScale,
      colorSet: GangnamColorPresets.emeraldGreen,
    ));
  }

  @override
  void render(Canvas canvas) {
    // 도로는 이제 컴포넌트로 처리되므로 직접 그리지 않음
    super.render(canvas);
  }

  bool isBlocked(Rect rect) {
    for (var b in _buildings) {
      final floorRect = Rect.fromLTWH(b.position.x, b.position.y - 30, b.size.x, 30);
      if (floorRect.overlaps(rect)) return true;
    }
    if (rect.top < 600) return true;
    return false;
  }
}
