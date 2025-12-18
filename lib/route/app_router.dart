import 'package:cocobuffett/home/home_page.dart';
import 'package:cocobuffett/inventory/inventory_page.dart';
import 'package:cocobuffett/shop/shop_page.dart';
import 'package:cocobuffett/stock/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/stock',
        name: 'stock',
        builder: (context, state) => const StockPage(),
      ),
      GoRoute(
        path: '/shop',
        name: 'shop',
        builder: (context, state) => const ShopPage(),
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (context, state) => const InventoryPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

