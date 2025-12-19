import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../game/coco_game.dart';
import '../game/player_bloc/player_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CocoGame game;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // game이 아직 초기화되지 않았을 때만 초기화
    if (!_isGameInitialized) {
      final playerBloc = context.read<PlayerBloc>();
      game = CocoGame(
        playerBloc: playerBloc,
        onEnterShop: () {
          if (mounted) {
            context.push('/shop');
          }
        },
      );
      _isGameInitialized = true;
    }
  }

  bool _isGameInitialized = false;

  @override
  Widget build(BuildContext context) {
    final playerBloc = context.read<PlayerBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('COCO Buffett'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          GameWidget(game: game),
          // 상점 버튼
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'shop_button',
              onPressed: () => context.push('/shop'),
              backgroundColor: const Color(0xFF4A90E2),
              child: const Icon(Icons.shopping_bag),
            ),
          ),
          // 인벤토리 버튼
          Positioned(
            top: 90,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'inventory_button',
              onPressed: () => context.push('/inventory'),
              backgroundColor: const Color(0xFF9B59B6),
              child: const Icon(Icons.inventory),
            ),
          ),
          // 자산 버튼
          Positioned(
            top: 160,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'asset_button',
              onPressed: () => context.push('/asset'),
              backgroundColor: const Color(0xFFE67E22),
              child: const Icon(Icons.account_balance_wallet),
            ),
          ),
          // 주식창 버튼
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'stock_button',
              onPressed: () => context.push('/stock'),
              backgroundColor: Colors.green,
              child: const Icon(Icons.show_chart),
            ),
          ),
          // 방향 컨트롤 버튼
          Positioned(
            right: 20,
            bottom: 20,
            child: _buildDirectionPad(),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionPad() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // 위
          Positioned(
            top: 0,
            left: 50,
            child: _buildDirectionButton(Icons.arrow_upward, Vector2(0, -1)),
          ),
          // 아래
          Positioned(
            bottom: 0,
            left: 50,
            child: _buildDirectionButton(Icons.arrow_downward, Vector2(0, 1)),
          ),
          // 왼쪽
          Positioned(
            left: 0,
            top: 50,
            child: _buildDirectionButton(Icons.arrow_back, Vector2(-1, 0)),
          ),
          // 오른쪽
          Positioned(
            right: 0,
            top: 50,
            child: _buildDirectionButton(Icons.arrow_forward, Vector2(1, 0)),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionButton(IconData icon, Vector2 direction) {
    final playerBloc = context.read<PlayerBloc>();
    return GestureDetector(
      onTapDown: (_) => playerBloc.add(PlayerEvent.moveStarted(direction)),
      onTapUp: (_) => playerBloc.add(const PlayerEvent.moveStopped()),
      onTapCancel: () => playerBloc.add(const PlayerEvent.moveStopped()),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 30),
      ),
    );
  }
}

