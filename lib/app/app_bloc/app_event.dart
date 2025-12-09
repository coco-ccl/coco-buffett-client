part of 'app_bloc.dart';

@freezed
sealed class AppEvent with _$AppEvent {
  const factory AppEvent.started() = _Started;
  const factory AppEvent.localeChanged(String locale) = _AppLocaleChanged;
}