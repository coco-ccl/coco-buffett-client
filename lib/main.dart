import 'package:cocobuffett/app/app_bloc/app_bloc.dart';
import 'package:cocobuffett/game/player_bloc/player_bloc.dart';
import 'package:cocobuffett/data/repositories/asset_repository.dart';
import 'package:cocobuffett/data/repositories/item_repository.dart';
import 'package:cocobuffett/data/repositories/stock_repository.dart';
import 'package:cocobuffett/data/repositories/auth_repository.dart';
import 'package:cocobuffett/data/repositories/member_repository.dart';
import 'package:cocobuffett/data/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route/app_router.dart';

// 전역 ApiClient - 모든 Repository가 공유
final apiClient = ApiClient();

// MemberRepository 생성 (AuthRepository가 사용)
final memberRepository = MemberRepository(apiClient: apiClient, useMockData: false);

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
          create: (_) => AuthRepository(apiClient: apiClient, useMockData: false),
        ),
        RepositoryProvider.value(value: memberRepository),
        RepositoryProvider(
          create: (_) => AssetRepository(apiClient: apiClient, useMockData: false),
        ),
        RepositoryProvider(
          create: (_) => ItemRepository(apiClient: apiClient, useMockData: false),
        ),
        RepositoryProvider(
          create: (_) => StockRepository(apiClient: apiClient, useMockData: false),
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
