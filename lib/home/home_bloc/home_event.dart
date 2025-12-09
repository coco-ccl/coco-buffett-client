part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
    // initial load events (optional)
    const factory HomeEvent.started() = _Started;
}