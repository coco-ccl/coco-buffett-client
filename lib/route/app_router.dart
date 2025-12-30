import 'package:cocobuffett/asset/asset_page.dart';
import 'package:cocobuffett/auth/signup_page.dart';
import 'package:cocobuffett/auth/login_page.dart';
import 'package:cocobuffett/home/home_page.dart';
import 'package:cocobuffett/inventory/inventory_page.dart';
import 'package:cocobuffett/minigame/minigame_page.dart';
import 'package:cocobuffett/shop/shop_page.dart';
import 'package:cocobuffett/stock/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/signup',
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
      GoRoute(
        path: '/asset',
        name: 'asset',
        builder: (context, state) => const AssetPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/minigame',
        name: 'minigame',
        builder: (context, state) => const MinigamePage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

