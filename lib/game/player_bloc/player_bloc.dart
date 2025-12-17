import 'dart:async';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sprite_layers.dart';

part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.freezed.dart';

/// 플레이어 BLoC - 캐릭터 상태 및 커스터마이징 관리
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(_initState) {
    on<_MoveStarted>(_onMoveStarted);
    on<_MoveStopped>(_onMoveStopped);
    on<_FaceChanged>(_onFaceChanged);
    on<_HairChanged>(_onHairChanged);
    on<_TopChanged>(_onTopChanged);
    on<_BottomChanged>(_onBottomChanged);
    on<_ShoesChanged>(_onShoesChanged);
  }

  static PlayerState get _initState => const PlayerState.idle(PlayerData());

  FutureOr<void> _onMoveStarted(
    _MoveStarted event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.moving(state.data.copyWith(
      velocity: event.direction,
      direction: _getDirection(event.direction),
    )));
  }

  FutureOr<void> _onMoveStopped(
    _MoveStopped event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.idle(state.data.copyWith(
      velocity: Vector2.zero(),
    )));
  }

  FutureOr<void> _onFaceChanged(
    _FaceChanged event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.customizing(state.data.copyWith(faceId: event.faceId)));
    // 커스터마이징 완료 후 이전 상태로 복원
    await Future.delayed(const Duration(milliseconds: 100));
    emit(PlayerState.idle(state.data));
  }

  FutureOr<void> _onHairChanged(
    _HairChanged event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.customizing(state.data.copyWith(hairId: event.hairId)));
    await Future.delayed(const Duration(milliseconds: 100));
    emit(PlayerState.idle(state.data));
  }

  FutureOr<void> _onTopChanged(
    _TopChanged event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.customizing(state.data.copyWith(topId: event.topId)));
    await Future.delayed(const Duration(milliseconds: 100));
    emit(PlayerState.idle(state.data));
  }

  FutureOr<void> _onBottomChanged(
    _BottomChanged event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.customizing(state.data.copyWith(bottomId: event.bottomId)));
    await Future.delayed(const Duration(milliseconds: 100));
    emit(PlayerState.idle(state.data));
  }

  FutureOr<void> _onShoesChanged(
    _ShoesChanged event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerState.customizing(state.data.copyWith(shoesId: event.shoesId)));
    await Future.delayed(const Duration(milliseconds: 100));
    emit(PlayerState.idle(state.data));
  }

  Direction _getDirection(Vector2 velocity) {
    if (velocity.x.abs() > velocity.y.abs()) {
      return velocity.x > 0 ? Direction.right : Direction.left;
    } else if (velocity.y != 0) {
      return velocity.y > 0 ? Direction.down : Direction.up;
    }
    return state.data.direction;
  }
}
