import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import '../components/player.dart';
import 'player_bloc/player_bloc.dart';
import 'keyboard_input_handler.dart';

/// COCO 게임 - Flame 기반 2D 캐릭터 게임
class CocoGame extends FlameGame with HasKeyboardHandlerComponents {
  final PlayerBloc playerBloc;
  KeyboardInputHandler? _keyboardHandler;

  CocoGame({required this.playerBloc});

  @override
  Color backgroundColor() => const Color(0xFFF0F0F0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // PlayerBloc Provider 추가
    await add(
      FlameBlocProvider<PlayerBloc, PlayerState>.value(
        value: playerBloc,
        children: [
          Player(),
        ],
      ),
    );

    // 키보드 핸들러 추가
    _keyboardHandler = KeyboardInputHandler(playerBloc);
    await add(_keyboardHandler!);
  }
}
