import 'package:cocobuffett/app/app_bloc/app_bloc.dart';
import 'package:cocobuffett/game/player_bloc/player_bloc.dart';
import 'package:cocobuffett/stock/stock_bloc/stock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route/app_router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PlayerBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => StockBloc()..add(const StockEvent.started()),
          lazy: false,
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.data.locale,
      builder: (context, locale) {
        return MaterialApp.router(
          title: 'Cocobuffett',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
