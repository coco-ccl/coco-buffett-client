import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_event_model.freezed.dart';

/// 이벤트 효과 타입
enum EventEffectType {
  allUp,
  allDown,
  sectorUp,
  sectorDown,
  dividend,
  newStock,
  randomCrash,
}

/// 이벤트 효과
@freezed
sealed class EventEffect with _$EventEffect {
  const factory EventEffect({
    required EventEffectType type,
    @Default(0) double value,
    @Default([]) List<String> sectors,
    @Default(0) int duration, // seconds
  }) = _EventEffect;
}

/// 주식 이벤트 모델
@freezed
sealed class StockEventModel with _$StockEventModel {
  const factory StockEventModel({
    required String id,
    required String title,
    required String description,
    required EventEffect effect,
    required double probability,
    required bool isPositive,
    DateTime? startTime,
  }) = _StockEventModel;
}
