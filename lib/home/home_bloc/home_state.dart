part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure, loading }

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.empty(HomeData data) = HomeEmpty;
}

@freezed
abstract class HomeData with _$HomeData {
  const factory HomeData({
    @Default(HomeStatus.initial) HomeStatus status,
    @Default('') String sample,
  }) = _HomeData;
}