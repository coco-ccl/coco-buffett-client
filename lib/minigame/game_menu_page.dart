import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/bgm_service.dart';

class GameMenuPage extends StatefulWidget {
  const GameMenuPage({super.key});

  @override
  State<GameMenuPage> createState() => _GameMenuPageState();
}

class _GameMenuPageState extends State<GameMenuPage> {
  final BgmService _bgmService = BgmService();

  @override
  void initState() {
    super.initState();
    // 오락실 BGM 재생 (나중에 추가 예정)
    // _bgmService.play(BgmType.arcade);
  }

  @override
  void dispose() {
    // 홈 BGM으로 복귀
    _bgmService.play(BgmType.home);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text(
          '게임 센터',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF16213E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF16213E),
              const Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 네온 스타일 타이틀
              Text(
                '🎮 게임 센터 🎮',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFFF00FF),
                  shadows: [
                    Shadow(
                      color: const Color(0xFFFF00FF).withValues(alpha: 0.8),
                      blurRadius: 20,
                    ),
                    const Shadow(
                      color: Colors.white,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '주식 할 돈이 없으신가요? 미니 게임을 통해 벌어보세요!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 게임 버튼들
              _buildGameButton(
                context,
                title: '버튼 누르기',
                subtitle: '10초 안에 최대한 많이 터치하세요!',
                icon: Icons.touch_app,
                color: const Color(0xFFFF6B6B),
                onPressed: () => context.push('/minigame'),
              ),
              const SizedBox(height: 24),
              _buildGameButton(
                context,
                title: '코코를 잡아라',
                subtitle: '움직이는 코코를 잡아보세요!',
                icon: Icons.catching_pokemon,
                color: const Color(0xFF66BB6A),
                onPressed: () => context.push('/catch-coco'),
              ),
              const SizedBox(height: 24),
              _buildGameButton(
                context,
                title: '똥피하기',
                subtitle: '30초 동안 똥을 피해 살아남으세요!',
                icon: Icons.directions_run,
                color: const Color(0xFF8D6E63),
                onPressed: () => context.push('/dodge-poop'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F3460).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                      shadows: [
                        Shadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withValues(alpha: 0.7),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
