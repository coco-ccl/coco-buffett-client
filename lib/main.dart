import 'package:cocobuffett/app/app_bloc/app_bloc.dart';
import 'package:cocobuffett/asset/asset_bloc/asset_bloc.dart';
import 'package:cocobuffett/game/player_bloc/player_bloc.dart';
import 'package:cocobuffett/stock/stock_bloc/stock_bloc.dart';
import 'package:cocobuffett/data/repositories/auth_repository.dart';
import 'package:cocobuffett/data/repositories/item_repository.dart';
import 'package:cocobuffett/data/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route/app_router.dart';

// 전역 ApiClient - 모든 Repository가 공유
final apiClient = ApiClient();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            apiClient: apiClient,
            useMockData: false,
          ),
        ),
        RepositoryProvider(
          create: (context) => ItemRepository(
            apiClient: apiClient,
            useMockData: false,
          ),
        ),
      ],
      child: MultiBlocProvider(
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
          BlocProvider(
            create: (context) => AssetBloc(),
            lazy: false,
          ),
        ],
        child: const AppView(),
      ),
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
