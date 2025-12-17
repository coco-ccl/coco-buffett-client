part of 'player_bloc.dart';

@freezed
sealed class PlayerState with _$PlayerState {
  /// 정지 상태
  const factory PlayerState.idle(PlayerData data) = PlayerIdle;

  /// 이동 중
  const factory PlayerState.moving(PlayerData data) = PlayerMoving;

  /// 커스터마이징 중
  const factory PlayerState.customizing(PlayerData data) = PlayerCustomizing;
}

@freezed
abstract class PlayerData with _$PlayerData {
  const factory PlayerData({
    @Default('default') String faceId,
    @Default('short_brown') String hairId,
    @Default('tshirt_white') String topId,
    @Default('pants_black') String bottomId,
    @Default('shoes_black') String shoesId,
    @Default(Direction.down) Direction direction,
    Vector2? velocity,
  }) = _PlayerData;
}
