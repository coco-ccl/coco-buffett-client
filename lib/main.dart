import 'package:cocobuffett/app/app_bloc/app_bloc.dart';
import 'package:cocobuffett/asset/asset_bloc/asset_bloc.dart';
import 'package:cocobuffett/game/player_bloc/player_bloc.dart';
import 'package:cocobuffett/stock/stock_bloc/stock_bloc.dart';
import 'package:cocobuffett/shop/shop_bloc/shop_bloc.dart';
import 'package:cocobuffett/data/repositories/asset_repository.dart';
import 'package:cocobuffett/data/repositories/item_repository.dart';
import 'package:cocobuffett/data/repositories/stock_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route/app_router.dart';

// Repository 전역 인스턴스
late final AssetRepository _assetRepository;
late final ItemRepository _itemRepository;
late final StockRepository _stockRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Repository 생성 및 초기화 (await으로 완료 대기)
  _assetRepository = AssetRepository(useMockData: true);
  _itemRepository = ItemRepository(useMockData: true);
  _stockRepository = StockRepository(useMockData: true);

  await _assetRepository.initialize();
  await _itemRepository.initialize();
  await _stockRepository.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AssetRepository>.value(value: _assetRepository),
        RepositoryProvider<ItemRepository>.value(value: _itemRepository),
        RepositoryProvider<StockRepository>.value(value: _stockRepository),
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
            create: (context) => StockBloc(
              assetRepository: context.read<AssetRepository>(),
              stockRepository: context.read<StockRepository>(),
            )..add(const StockEvent.started()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => AssetBloc(
              assetRepository: context.read<AssetRepository>(),
            )..add(const AssetEvent.started()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => ShopBloc(
              assetRepository: context.read<AssetRepository>(),
              itemRepository: context.read<ItemRepository>(),
            )..add(const ShopEvent.started()),
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
