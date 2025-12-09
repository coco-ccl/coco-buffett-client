import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(_initState) {
    on<_Started>(_onStarted);
    on<_AppLocaleChanged>(_onAppLocaleChanged);
  }

  static AppState get _initState => const AppState.empty(AppData());

  FutureOr<void> _onStarted(_Started event, Emitter<AppState> emit) async {
    // 초기화 로직
  }

  FutureOr<void> _onAppLocaleChanged(
    _AppLocaleChanged event,
    Emitter<AppState> emit,
  ) async {
    emit(AppState.empty(state.data.copyWith(locale: event.locale)));
  }
}