part of 'player_bloc.dart';

@freezed
sealed class PlayerEvent with _$PlayerEvent {
  /// 이동 시작
  const factory PlayerEvent.moveStarted(Vector2 direction) = _MoveStarted;

  /// 이동 정지
  const factory PlayerEvent.moveStopped() = _MoveStopped;

  /// 얼굴 변경
  const factory PlayerEvent.faceChanged(String faceId) = _FaceChanged;

  /// 헤어 변경
  const factory PlayerEvent.hairChanged(String hairId) = _HairChanged;

  /// 상의 변경
  const factory PlayerEvent.topChanged(String topId) = _TopChanged;

  /// 하의 변경
  const factory PlayerEvent.bottomChanged(String bottomId) = _BottomChanged;

  /// 신발 변경
  const factory PlayerEvent.shoesChanged(String shoesId) = _ShoesChanged;
}
