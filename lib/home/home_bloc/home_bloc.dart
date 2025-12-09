import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
    HomeBloc() : super(_initState) {
        on<HomeEvent>((event, emit) {
            // TODO: implement event handler
        });
    }
    
    static HomeState get _initState => const HomeState.empty(HomeData());
}