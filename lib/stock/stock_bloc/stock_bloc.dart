import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stock_event.dart';
part 'stock_state.dart';
part 'stock_bloc.freezed.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(_initState) {
    on<StockEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  static StockState get _initState => const StockState.empty(StockData());
}
