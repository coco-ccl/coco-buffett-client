import 'dart:async';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sprite_layers.dart';
import '../../data/repositories/item_repository.dart';

part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.freezed.dart';

/// 플레이어 BLoC - 캐릭터 상태 및 커스터마이징 관리
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final ItemRepository _itemRepository;

  PlayerBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(_initState) {
    on<_MoveStarted>(_onMoveStarted);
    on<_MoveStopped>(_onMoveStopped);
    on<_FaceChanged>(_onFaceChanged);
    on<_HairChanged>(_onHairChanged);
    on<_TopChanged>(_onTopChanged);
    on<_BottomChanged>(_onBottomChanged);
    on<_ShoesChanged>(_onShoesChanged);
    on<_LoadEquippedItems>(_onLoadEquippedItems);
    on<_SetAllItems>(_onSetAllItems);
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

  FutureOr<void> _onLoadEquippedItems(
    _LoadEquippedItems event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      print('[PlayerBloc] 착용 아이템 로드 시작');
      final equippedItems = await _itemRepository.getEquippedItems();

      // 착용 아이템을 타입별로 매핑
      String? faceId;
      String? hairId;
      String? topId;
      String? bottomId;
      String? shoesId;

      for (final item in equippedItems) {
        switch (item.type) {
          case 'face':
            faceId = item.itemId;
            break;
          case 'hair':
            hairId = item.itemId;
            break;
          case 'top':
            topId = item.itemId;
            break;
          case 'bottom':
            bottomId = item.itemId;
            break;
          case 'shoes':
            shoesId = item.itemId;
            break;
        }
      }

      // PlayerData 업데이트
      emit(PlayerState.idle(state.data.copyWith(
        faceId: faceId ?? state.data.faceId,
        hairId: hairId ?? state.data.hairId,
        topId: topId ?? state.data.topId,
        bottomId: bottomId ?? state.data.bottomId,
        shoesId: shoesId ?? state.data.shoesId,
      )));

      print('[PlayerBloc] 착용 아이템 로드 완료: face=$faceId, hair=$hairId, top=$topId, bottom=$bottomId, shoes=$shoesId');
    } catch (e) {
      print('[PlayerBloc] 착용 아이템 로드 실패: $e');
      // 에러 발생 시 기본값 유지
    }
  }

  FutureOr<void> _onSetAllItems(
    _SetAllItems event,
    Emitter<PlayerState> emit,
  ) async {
    print('[PlayerBloc] 모든 아이템 설정: face=${event.faceId}, hair=${event.hairId}, top=${event.topId}, bottom=${event.bottomId}, shoes=${event.shoesId}');
    emit(PlayerState.idle(state.data.copyWith(
      faceId: event.faceId,
      hairId: event.hairId,
      topId: event.topId,
      bottomId: event.bottomId,
      shoesId: event.shoesId,
    )));
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
