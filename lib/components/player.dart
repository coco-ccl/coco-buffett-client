import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import '../game/sprite_layers.dart';
import '../game/player_bloc/player_bloc.dart';
import '../game/coco_game.dart';

class Player extends PositionComponent
    with HasGameReference<CocoGame>, FlameBlocReader<PlayerBloc, PlayerState> {
  Map<Direction, ui.Image>? _images;

  static const double speed = 150.0;
  static const double spriteScale = 1.5;
  static const int pixelSize = 32;

  Player() : super(
    size: Vector2(
      pixelSize * spriteScale,
      pixelSize * spriteScale,
    ),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(
      FlameBlocListener<PlayerBloc, PlayerState>(
        onNewState: (state) => _onPlayerStateChanged(state),
      ),
    );

    await _regenerateSprites();

    // 안전한 스폰 지점으로 위치 설정 (CityMap에서 가져옴)
    position = game.cityMap.spawnPoint.clone();
  }

  Future<void> _onPlayerStateChanged(PlayerState state) async {
    if (state is PlayerCustomizing) {
      await _regenerateSprites();
    }
  }

  Future<void> _regenerateSprites() async {
    final data = bloc.state.data;
    _images = await SpriteLayerGenerator.generateAllDirections(
      faceId: data.faceId,
      hairId: data.hairId,
      topId: data.topId,
      bottomId: data.bottomId,
      shoesId: data.shoesId,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final velocity = bloc.state.data.velocity ?? Vector2.zero();
    if (velocity.isZero()) return;

    final displacement = velocity * speed * dt;
    
    // 히트박스: 캐릭터의 발 주변 (중앙 하단)
    // 캐릭터 가로가 64픽셀일 때, 중앙 24픽셀 정도만 충돌 판정
    Rect getHitbox(Vector2 pos) {
      return Rect.fromLTWH(
        pos.x + 20,          
        pos.y + size.y - 12, 
        size.x - 40,         
        8,                   
      );
    }

    // 1. X축 이동 체크
    final nextXPos = position.clone()..x += displacement.x;
    if (!game.cityMap.isBlocked(getHitbox(nextXPos))) {
      position.x = nextXPos.x;
    }

    // 2. Y축 이동 체크
    final nextYPos = position.clone()..y += displacement.y;
    if (!game.cityMap.isBlocked(getHitbox(nextYPos))) {
      position.y = nextYPos.y;
    }

    // 화면 경계 제한
    position.x = position.x.clamp(0, game.size.x - size.x);
    position.y = position.y.clamp(0, game.size.y - size.y);
  }

  @override
  void render(Canvas canvas) {
    if (_images == null) return;
    final direction = bloc.state.data.direction;
    final image = _images![direction]!;
    final paint = Paint()
      ..filterQuality = FilterQuality.none
      ..isAntiAlias = false;
    final srcRect = Rect.fromLTWH(0, 0, pixelSize.toDouble(), pixelSize.toDouble());
    final dstRect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawImageRect(image, srcRect, dstRect, paint);
  }
}
