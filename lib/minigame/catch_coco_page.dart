import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../data/repositories/asset_repository.dart';

/// 코코 캐릭터 타입
enum CocoType {
  normal(1000, 'assets/images/coco_logo.png'),
  rich(5000, 'assets/images/coco_rich.png'),
  poor(-2000, 'assets/images/coco_poor.png');

  final int reward;
  final String imagePath;
  const CocoType(this.reward, this.imagePath);
}

/// 떠다니는 코코 캐릭터
class FloatingCoco {
  final String id;
  final CocoType type;
  double x;
  double y;
  double dx;
  double dy;
  double size;

  FloatingCoco({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    this.size = 80,
  });
}

class CatchCocoPage extends StatefulWidget {
  const CatchCocoPage({super.key});

  @override
  State<CatchCocoPage> createState() => _CatchCocoPageState();
}

class _CatchCocoPageState extends State<CatchCocoPage> {
  static const int gameDuration = 30;
  static const int maxCocos = 30;

  final Random _random = Random();
  final List<FloatingCoco> _cocos = [];

  int _score = 0;
  int _remainingSeconds = gameDuration;
  bool _isPlaying = false;
  bool _isGameOver = false;
  Timer? _gameTimer;
  Timer? _moveTimer;
  Timer? _spawnTimer;

  Size _screenSize = Size.zero;

  @override
  void dispose() {
    _gameTimer?.cancel();
    _moveTimer?.cancel();
    _spawnTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _remainingSeconds = gameDuration;
      _isPlaying = true;
      _isGameOver = false;
      _cocos.clear();
    });

    // 초기 코코 생성
    for (int i = 0; i < 15; i++) {
      _spawnCoco();
    }

    // 게임 타이머 (1초마다)
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        _endGame();
      }
    });

    // 이동 타이머 (16ms마다 - 약 60fps)
    _moveTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _moveCocos();
    });

    // 스폰 타이머 (1초마다 2마리씩)
    _spawnTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_cocos.length < maxCocos) {
        _spawnCoco();
        if (_cocos.length < maxCocos) {
          _spawnCoco();
        }
      }
    });
  }

  void _spawnCoco() {
    if (_screenSize == Size.zero) return;

    // 타입 결정 (normal 55%, poor 25%, rich 20%)
    final rand = _random.nextDouble();
    CocoType type;
    if (rand < 0.20) {
      type = CocoType.rich;
    } else if (rand < 0.45) {
      type = CocoType.poor;
    } else {
      type = CocoType.normal;
    }

    final size = type == CocoType.rich ? 60.0 : (type == CocoType.poor ? 70.0 : 80.0);
    final speed = type == CocoType.rich ? 6.0 : (type == CocoType.poor ? 3.0 : 2.5);

    final coco = FloatingCoco(
      id: DateTime.now().millisecondsSinceEpoch.toString() + _random.nextInt(1000).toString(),
      type: type,
      x: _random.nextDouble() * (_screenSize.width - size - 40) + 20,
      y: _random.nextDouble() * (_screenSize.height - size - 200) + 100,
      dx: (_random.nextDouble() - 0.5) * speed * 2,
      dy: (_random.nextDouble() - 0.5) * speed * 2,
      size: size,
    );

    setState(() {
      _cocos.add(coco);
    });
  }

  void _moveCocos() {
    if (!_isPlaying) return;

    setState(() {
      for (final coco in _cocos) {
        coco.x += coco.dx;
        coco.y += coco.dy;

        // 벽에 부딪히면 반사
        if (coco.x <= 0 || coco.x >= _screenSize.width - coco.size - 20) {
          coco.dx = -coco.dx;
          coco.x = coco.x.clamp(0, _screenSize.width - coco.size - 20);
        }
        if (coco.y <= 80 || coco.y >= _screenSize.height - coco.size - 150) {
          coco.dy = -coco.dy;
          coco.y = coco.y.clamp(80, _screenSize.height - coco.size - 150);
        }
      }
    });
  }

  void _catchCoco(FloatingCoco coco) {
    if (!_isPlaying) return;

    setState(() {
      _score += coco.type.reward;
      _cocos.removeWhere((c) => c.id == coco.id);
    });

    // 새 코코 스폰
    if (_cocos.length < 2) {
      _spawnCoco();
    }
  }

  Future<void> _endGame() async {
    _gameTimer?.cancel();
    _moveTimer?.cancel();
    _spawnTimer?.cancel();

    setState(() {
      _isPlaying = false;
      _isGameOver = true;
      _cocos.clear();
    });

    // 서버에 점수 저장 (양수/음수 모두)
    if (_score != 0) {
      final assetRepository = context.read<AssetRepository>();
      await assetRepository.addCashFromServer(_score);
    }

    if (mounted) {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        title: const Text(
          '게임 종료!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/coco_logo.png',
              width: 100,
              height: 70,
            ),
            const SizedBox(height: 16),
            Text(
              _score >= 0 ? '획득 보상' : '손실 금액',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '${_score >= 0 ? '+' : ''}${_formatNumber(_score)}원',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: _score >= 0 ? const Color(0xFF4CAF50) : Colors.red,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isGameOver = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: const Text(
                '다시 하기',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black, width: 2),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                '나가기',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    final isNegative = number < 0;
    final absNumber = number.abs();
    final formatted = absNumber.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    return isNegative ? '-$formatted' : formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: const Text(
          '코코를 잡아라!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF66BB6A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          _screenSize = Size(constraints.maxWidth, constraints.maxHeight);

          return Stack(
            children: [
              // 상단 정보
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoCard(
                        icon: Icons.timer,
                        label: '남은 시간',
                        value: '$_remainingSeconds초',
                        color: _remainingSeconds <= 5
                            ? Colors.red
                            : const Color(0xFF66BB6A),
                      ),
                      _buildInfoCard(
                        icon: Icons.monetization_on,
                        label: '점수',
                        value: '${_formatNumber(_score)}원',
                        color: _score >= 0 ? const Color(0xFF4CAF50) : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),

              // 떠다니는 코코들
              ..._cocos.map((coco) => Positioned(
                    left: coco.x,
                    top: coco.y,
                    child: GestureDetector(
                      onTap: () => _catchCoco(coco),
                      child: Container(
                        width: coco.size,
                        height: coco.size,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          coco.type.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )),

              // 시작 버튼 또는 안내
              if (!_isPlaying && !_isGameOver)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStartButton(),
                      const SizedBox(height: 30),
                      _buildLegend(),
                    ],
                  ),
                ),

              // 하단 범례 (게임 중)
              if (_isPlaying)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: _buildLegend(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _startGame,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF66BB6A),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/coco_logo.png',
              width: 80,
              height: 60,
            ),
            const SizedBox(height: 8),
            const Text(
              '시작',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem('assets/images/coco_logo.png', '+1,000원', Colors.blue),
          _buildLegendItem('assets/images/coco_rich.png', '+5,000원', Colors.green),
          _buildLegendItem('assets/images/coco_poor.png', '-2,000원', Colors.red),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String imagePath, String text, Color color) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
