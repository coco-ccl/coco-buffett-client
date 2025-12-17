import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'player_bloc/player_bloc.dart';

/// 키보드 입력 처리 컴포넌트
class KeyboardInputHandler extends Component with KeyboardHandler {
  final PlayerBloc playerBloc;
  final Set<LogicalKeyboardKey> _pressedKeys = {};

  KeyboardInputHandler(this.playerBloc);

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _pressedKeys.clear();
    _pressedKeys.addAll(keysPressed);
    _updatePlayerMovement();
    return true;
  }

  void _updatePlayerMovement() {
    double dx = 0;
    double dy = 0;

    if (_pressedKeys.contains(LogicalKeyboardKey.arrowUp) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyW)) {
      dy -= 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowDown) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyS)) {
      dy += 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyA)) {
      dx -= 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyD)) {
      dx += 1;
    }

    if (dx != 0 || dy != 0) {
      // 방향 벡터 정규화
      final direction = Vector2(dx, dy);
      if (direction.length > 0) {
        direction.normalize();
      }
      playerBloc.add(PlayerEvent.moveStarted(direction));
    } else {
      playerBloc.add(const PlayerEvent.moveStopped());
    }
  }
}
