part of 'app_bloc.dart';

enum AppStatus { initial, success, failure, loading }

@freezed
sealed class AppState with _$AppState {
  const factory AppState.empty(AppData data) = AppEmpty;
}

@freezed
abstract class AppData with _$AppData {
  const factory AppData({
    @Default(AppStatus.initial) AppStatus status,
    @Default('') String sample,
    @Default('ko') String locale,
  }) = _AppData;
}