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
  late final PlayerBloc _playerBloc;
  late final CocoGame game;

  @override
  void initState() {
    super.initState();
    _playerBloc = PlayerBloc();
    game = CocoGame(playerBloc: _playerBloc);
  }

  @override
  void dispose() {
    _playerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _playerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('COCO Buffett'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Stack(
          children: [
            GameWidget(game: game),
            // 주식창 버튼
            Positioned(
              top: 20,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'stock_button',
                onPressed: () => context.go('/stock'),
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
            // 커스터마이징 버튼
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingActionButton(
                heroTag: 'customization_button',
                onPressed: () => _showCustomizationDialog(context),
                child: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
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
    return GestureDetector(
      onTapDown: (_) => _playerBloc.add(PlayerEvent.moveStarted(direction)),
      onTapUp: (_) => _playerBloc.add(const PlayerEvent.moveStopped()),
      onTapCancel: () => _playerBloc.add(const PlayerEvent.moveStopped()),
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

  void _showCustomizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('캐릭터 커스터마이징'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCustomizationSection(
                '얼굴',
                ['default', 'cute', 'cool'],
                (faceId) => _playerBloc.add(PlayerEvent.faceChanged(faceId)),
              ),
              _buildCustomizationSection(
                '헤어',
                ['short_brown', 'short_black', 'short_blonde', 'long_brown'],
                (hairId) => _playerBloc.add(PlayerEvent.hairChanged(hairId)),
              ),
              _buildCustomizationSection(
                '상의',
                ['tshirt_white', 'tshirt_blue', 'tshirt_red', 'tshirt_flower'],
                (topId) => _playerBloc.add(PlayerEvent.topChanged(topId)),
              ),
              _buildCustomizationSection(
                '하의',
                ['pants_black', 'pants_navy', 'jeans_blue'],
                (bottomId) => _playerBloc.add(PlayerEvent.bottomChanged(bottomId)),
              ),
              _buildCustomizationSection(
                '신발',
                ['shoes_black', 'sneakers_white'],
                (shoesId) => _playerBloc.add(PlayerEvent.shoesChanged(shoesId)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomizationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              '캐릭터 커스터마이징',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildCustomizationSection(
            '얼굴',
            ['default', 'cute', 'cool'],
            (faceId) => _playerBloc.add(PlayerEvent.faceChanged(faceId)),
          ),
          _buildCustomizationSection(
            '헤어',
            ['short_brown', 'short_black', 'short_blonde', 'long_brown', 'long_black', 'pomade_black', 'pomade_brown', 'gray'],
            (hairId) => _playerBloc.add(PlayerEvent.hairChanged(hairId)),
          ),
          _buildCustomizationSection(
            '상의',
            ['tshirt_white', 'tshirt_blue', 'tshirt_red', 'tshirt_green', 'tshirt_flower', 'shirt_white'],
            (topId) => _playerBloc.add(PlayerEvent.topChanged(topId)),
          ),
          _buildCustomizationSection(
            '하의',
            ['pants_black', 'pants_navy', 'pants_gray', 'jeans_blue'],
            (bottomId) => _playerBloc.add(PlayerEvent.bottomChanged(bottomId)),
          ),
          _buildCustomizationSection(
            '신발',
            ['shoes_black', 'shoes_brown', 'sneakers_white', 'sneakers_black'],
            (shoesId) => _playerBloc.add(PlayerEvent.shoesChanged(shoesId)),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationSection(
    String title,
    List<String> options,
    void Function(String) onSelect,
  ) {
    return ExpansionTile(
      title: Text(title),
      children: options.map((option) {
        return ListTile(
          title: Text(option),
          onTap: () => onSelect(option),
        );
      }).toList(),
    );
  }
}

