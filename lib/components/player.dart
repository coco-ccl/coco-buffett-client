import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import '../game/sprite_layers.dart';
import '../game/player_bloc/player_bloc.dart';

class Player extends PositionComponent
    with HasGameReference, FlameBlocReader<PlayerBloc, PlayerState> {
  Map<Direction, ui.Image>? _images;

  static const double speed = 150.0;
  static const double spriteScale = 2.0;
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

    // BLoC 리스너 추가
    await add(
      FlameBlocListener<PlayerBloc, PlayerState>(
        onNewState: (state) => _onPlayerStateChanged(state),
      ),
    );

    await _regenerateSprites();

    // 화면 중앙에 위치
    position = Vector2(
      (game.size.x - size.x) / 2,
      (game.size.y - size.y) / 2,
    );
  }

  /// BLoC 상태 변경 핸들러
  Future<void> _onPlayerStateChanged(PlayerState state) async {
    // 커스터마이징 시 스프라이트 재생성
    if (state is PlayerCustomizing) {
      await _regenerateSprites();
    }
  }

  /// 스프라이트 재생성 (BLoC 상태 기반)
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

    // BLoC 상태에서 velocity 가져오기
    final velocity = bloc.state.data.velocity ?? Vector2.zero();

    // 위치 업데이트
    position += velocity * speed * dt;

    // 화면 경계 체크
    position.x = position.x.clamp(0, game.size.x - size.x).toDouble();
    position.y = position.y.clamp(0, game.size.y - size.y).toDouble();
  }

  @override
  void render(Canvas canvas) {
    if (_images == null) return;

    // BLoC 상태에서 방향 가져오기
    final direction = bloc.state.data.direction;
    final image = _images![direction]!;

    // 픽셀 아트를 확대해서 그리기 (픽셀이 뭉개지지 않도록)
    final paint = Paint()
      ..filterQuality = FilterQuality.none
      ..isAntiAlias = false;

    final srcRect = Rect.fromLTWH(
      0, 0,
      pixelSize.toDouble(),
      pixelSize.toDouble(),
    );

    final dstRect = Rect.fromLTWH(0, 0, size.x, size.y);

    canvas.drawImageRect(image, srcRect, dstRect, paint);
  }
}
