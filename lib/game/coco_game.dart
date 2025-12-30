import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import '../components/player.dart';
import 'player_bloc/player_bloc.dart';
import 'keyboard_input_handler.dart';
import 'city_map.dart';
import 'components/game_background.dart';

/// COCO 게임 - Flame 기반 2D 캐릭터 게임
class CocoGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  final PlayerBloc playerBloc;
  final Function()? onEnterShop;
  final Function()? onEnterStock;
  final Function()? onEnterArcade;
  KeyboardInputHandler? _keyboardHandler;
  late CityMap cityMap;
  Player? _player;
  late World _world;

  CocoGame({
    required this.playerBloc,
    this.onEnterShop,
    this.onEnterStock,
    this.onEnterArcade,
  }) : super(
    world: World(),
    camera: CameraComponent(),
  );

  @override
  Color backgroundColor() => const Color(0xFF000000); // 폴백용 검정

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _world = world;

    // 게임 전체 배경 추가 (카메라 backdrop에)
    await camera.backdrop.add(GameBackground());

    // 맵 추가 (World에)
    cityMap = CityMap();
    await _world.add(cityMap);

    // Player 생성
    _player = Player();

    // PlayerBloc Provider 추가 (World에)
    await _world.add(
      FlameBlocProvider<PlayerBloc, PlayerState>.value(
        value: playerBloc,
        children: [
          _player!,
        ],
      ),
    );

    // 키보드 핸들러 추가 (World에)
    _keyboardHandler = KeyboardInputHandler(playerBloc);
    await _world.add(_keyboardHandler!);

    // 카메라 설정 - 플레이어를 화면 중하단에 배치하고 따라가도록
    // anchor를 bottomCenter로 하면 플레이어가 화면 하단에 위치
    // 0.7 정도로 설정하면 플레이어가 화면 하단 30% 지점에 위치
    camera.viewfinder.anchor = Anchor(0.5, 0.7); // x: 중앙, y: 하단에서 30% 위
    camera.follow(_player!);
  }
}
