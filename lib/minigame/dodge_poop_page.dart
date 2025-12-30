import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../data/repositories/asset_repository.dart';

/// 떨어지는 똥
class FallingPoop {
  final String id;
  double x;
  double y;
  double speed;
  double size;

  FallingPoop({
    required this.id,
    required this.x,
    required this.y,
    required this.speed,
    this.size = 40,
  });
}

/// 픽셀 똥 페인터
class PoopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final pixelSize = size.width / 8;

    // 똥 색상
    const brownDark = Color(0xFF5D4037);
    const brownMid = Color(0xFF795548);
    const brownLight = Color(0xFF8D6E63);
    const highlight = Color(0xFFA1887F);

    // 똥 픽셀 맵 (8x8)
    final pixels = [
      [0, 0, 0, 1, 1, 0, 0, 0],
      [0, 0, 1, 2, 2, 1, 0, 0],
      [0, 1, 2, 3, 2, 2, 1, 0],
      [0, 1, 2, 2, 2, 2, 1, 0],
      [1, 2, 2, 3, 2, 2, 2, 1],
      [1, 2, 2, 2, 2, 2, 2, 1],
      [1, 2, 2, 2, 2, 2, 2, 1],
      [0, 1, 1, 1, 1, 1, 1, 0],
    ];

    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        if (pixels[y][x] > 0) {
          switch (pixels[y][x]) {
            case 1:
              paint.color = brownDark;
              break;
            case 2:
              paint.color = brownMid;
              break;
            case 3:
              paint.color = highlight;
              break;
          }
          canvas.drawRect(
            Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize, pixelSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 픽셀 플레이어 페인터
class PlayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final pixelSize = size.width / 8;

    // 플레이어 색상
    const skinColor = Color(0xFFFFCC80);
    const hairColor = Color(0xFF5D4037);
    const shirtColor = Color(0xFF42A5F5);
    const pantsColor = Color(0xFF1565C0);
    const outlineColor = Color(0xFF212121);

    // 플레이어 픽셀 맵 (8x10)
    final pixels = [
      [0, 0, 1, 1, 1, 1, 0, 0], // 머리카락
      [0, 1, 1, 1, 1, 1, 1, 0],
      [0, 1, 2, 2, 2, 2, 1, 0], // 얼굴
      [0, 0, 2, 2, 2, 2, 0, 0],
      [0, 0, 3, 3, 3, 3, 0, 0], // 상의
      [0, 3, 3, 3, 3, 3, 3, 0],
      [0, 0, 3, 3, 3, 3, 0, 0],
      [0, 0, 4, 4, 4, 4, 0, 0], // 하의
      [0, 0, 4, 0, 0, 4, 0, 0],
      [0, 0, 5, 0, 0, 5, 0, 0], // 발
    ];

    for (int y = 0; y < 10; y++) {
      for (int x = 0; x < 8; x++) {
        if (pixels[y][x] > 0) {
          switch (pixels[y][x]) {
            case 1:
              paint.color = hairColor;
              break;
            case 2:
              paint.color = skinColor;
              break;
            case 3:
              paint.color = shirtColor;
              break;
            case 4:
              paint.color = pantsColor;
              break;
            case 5:
              paint.color = outlineColor;
              break;
          }
          canvas.drawRect(
            Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize, pixelSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DodgePoopPage extends StatefulWidget {
  const DodgePoopPage({super.key});

  @override
  State<DodgePoopPage> createState() => _DodgePoopPageState();
}

class _DodgePoopPageState extends State<DodgePoopPage> {
  static const int gameDuration = 30;
  static const double playerWidth = 50;
  static const double playerHeight = 62;

  final Random _random = Random();
  final List<FallingPoop> _poops = [];
  final FocusNode _focusNode = FocusNode();
  Timer? _keyHoldTimer;

  double _playerX = 0;
  int _survivalTime = 0;
  int _remainingSeconds = gameDuration;
  int _dodgedCount = 0;
  bool _isPlaying = false;
  bool _isGameOver = false;
  bool _isHit = false;
  Timer? _gameTimer;
  Timer? _moveTimer;
  Timer? _spawnTimer;

  Size _screenSize = Size.zero;

  @override
  void dispose() {
    _gameTimer?.cancel();
    _moveTimer?.cancel();
    _spawnTimer?.cancel();
    _keyHoldTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (!_isPlaying) return;

    if (event is KeyDownEvent) {
      // 키가 눌렸을 때 - 연속 이동 시작
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.keyA) {
        _keyHoldTimer?.cancel();
        _movePlayer(-15);
        _keyHoldTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
          _movePlayer(-10);
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        _keyHoldTimer?.cancel();
        _movePlayer(15);
        _keyHoldTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
          _movePlayer(10);
        });
      }
    } else if (event is KeyUpEvent) {
      // 키를 뗐을 때 - 이동 중지
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.keyA ||
          event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        _keyHoldTimer?.cancel();
      }
    }
  }

  void _startGame() {
    setState(() {
      _survivalTime = 0;
      _remainingSeconds = gameDuration;
      _dodgedCount = 0;
      _isPlaying = true;
      _isGameOver = false;
      _isHit = false;
      _poops.clear();
      _playerX = (_screenSize.width - playerWidth) / 2;
    });

    // 게임 타이머 (1초마다)
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        _survivalTime++;
      });

      if (_remainingSeconds <= 0) {
        _endGame(survived: true);
      }
    });

    // 이동 및 충돌 타이머 (16ms마다)
    _moveTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _movePoops();
      _checkCollision();
    });

    // 스폰 타이머 (난이도에 따라 변화)
    _startSpawnTimer();
  }

  void _startSpawnTimer() {
    _spawnTimer?.cancel();
    // 시간이 지날수록 더 빠르게 스폰 (400ms ~ 150ms)
    final spawnInterval = max(150, 400 - (_survivalTime * 10));
    _spawnTimer = Timer.periodic(Duration(milliseconds: spawnInterval), (timer) {
      // 시간이 지날수록 한 번에 더 많은 똥 스폰
      final poopCount = 1 + (_survivalTime ~/ 5); // 5초마다 +1개씩 증가
      for (int i = 0; i < poopCount; i++) {
        _spawnPoop();
      }
      // 난이도 업데이트
      if (_survivalTime % 5 == 0) {
        _startSpawnTimer();
      }
    });
  }

  void _spawnPoop() {
    if (_screenSize == Size.zero || !_isPlaying) return;

    final poop = FallingPoop(
      id: DateTime.now().millisecondsSinceEpoch.toString() + _random.nextInt(1000).toString(),
      x: _random.nextDouble() * (_screenSize.width - 40),
      y: -40,
      speed: 3 + _random.nextDouble() * 3 + (_survivalTime * 0.1),
      size: 35 + _random.nextDouble() * 15,
    );

    setState(() {
      _poops.add(poop);
    });
  }

  void _movePoops() {
    if (!_isPlaying) return;

    setState(() {
      for (final poop in _poops) {
        poop.y += poop.speed;
      }

      // 화면 밖으로 나간 똥 제거 및 카운트
      final removed = _poops.where((p) => p.y > _screenSize.height).length;
      _dodgedCount += removed;
      _poops.removeWhere((p) => p.y > _screenSize.height);
    });
  }

  void _checkCollision() {
    if (!_isPlaying || _isHit) return;

    final playerRect = Rect.fromLTWH(
      _playerX + 10,
      _screenSize.height - playerHeight - 80,
      playerWidth - 20,
      playerHeight - 10,
    );

    for (final poop in _poops) {
      final poopRect = Rect.fromLTWH(
        poop.x + 5,
        poop.y + 5,
        poop.size - 10,
        poop.size - 10,
      );

      if (playerRect.overlaps(poopRect)) {
        _isHit = true;
        _endGame(survived: false);
        return;
      }
    }
  }

  void _movePlayer(double dx) {
    if (!_isPlaying) return;

    setState(() {
      _playerX = (_playerX + dx).clamp(0, _screenSize.width - playerWidth);
    });
  }

  Future<void> _endGame({required bool survived}) async {
    _gameTimer?.cancel();
    _moveTimer?.cancel();
    _spawnTimer?.cancel();

    setState(() {
      _isPlaying = false;
      _isGameOver = true;
    });

    // 보상 계산: 생존 시간 * 100 + 피한 똥 * 50
    final reward = survived
        ? (_survivalTime * 100) + (_dodgedCount * 50) + 5000  // 완주 보너스
        : (_survivalTime * 50) + (_dodgedCount * 20);  // 실패 시 절반

    if (reward > 0) {
      final assetRepository = context.read<AssetRepository>();
      await assetRepository.addCashFromServer(reward);
    }

    if (mounted) {
      _showResultDialog(survived, reward);
    }
  }

  void _showResultDialog(bool survived, int reward) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        title: Text(
          survived ? '완주 성공!' : '똥 맞음!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: survived ? Colors.green : Colors.brown,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CustomPaint(painter: PoopPainter()),
            ),
            const SizedBox(height: 16),
            Text('생존 시간: $_survivalTime초'),
            Text('피한 똥: $_dodgedCount개'),
            const SizedBox(height: 8),
            Text(
              '+${_formatNumber(reward)}원',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
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
                backgroundColor: const Color(0xFF8D6E63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: const Text('다시 하기', style: TextStyle(fontWeight: FontWeight.bold)),
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
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('나가기', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      appBar: AppBar(
        title: const Text(
          '똥피하기',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8D6E63),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            _screenSize = Size(constraints.maxWidth, constraints.maxHeight);
            if (_playerX == 0 && !_isPlaying) {
              _playerX = (_screenSize.width - playerWidth) / 2;
            }

            return GestureDetector(
            onHorizontalDragUpdate: (details) {
              _movePlayer(details.delta.dx);
            },
            child: Stack(
              children: [
                // 배경 구름
                ..._buildClouds(),

                // 땅
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    color: const Color(0xFF4CAF50),
                    child: CustomPaint(
                      painter: GrassPainter(),
                      size: Size(_screenSize.width, 60),
                    ),
                  ),
                ),

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
                        _buildInfoCard(Icons.timer, '$_remainingSeconds초',
                            _remainingSeconds <= 5 ? Colors.red : Colors.blue),
                        _buildInfoCard(Icons.shield, '$_dodgedCount개', Colors.green),
                      ],
                    ),
                  ),
                ),

                // 떨어지는 똥들
                ..._poops.map((poop) => Positioned(
                      left: poop.x,
                      top: poop.y,
                      child: SizedBox(
                        width: poop.size,
                        height: poop.size,
                        child: CustomPaint(painter: PoopPainter()),
                      ),
                    )),

                // 플레이어
                if (_isPlaying)
                  Positioned(
                    left: _playerX,
                    bottom: 70,
                    child: SizedBox(
                      width: playerWidth,
                      height: playerHeight,
                      child: CustomPaint(painter: PlayerPainter()),
                    ),
                  ),

                // 시작 버튼
                if (!_isPlaying && !_isGameOver)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _startGame,
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8D6E63),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CustomPaint(painter: PoopPainter()),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '시작',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                '좌우로 드래그하여 똥을 피하세요!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '⌨️ 키보드: ← → 또는 A D',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                // 조작 버튼 (게임 중)
                if (_isPlaying)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTapDown: (_) => _movePlayer(-20),
                          onLongPressStart: (_) {
                            Timer.periodic(const Duration(milliseconds: 50), (timer) {
                              if (!_isPlaying) timer.cancel();
                              _movePlayer(-10);
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(Icons.arrow_left, size: 40),
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (_) => _movePlayer(20),
                          onLongPressStart: (_) {
                            Timer.periodic(const Duration(milliseconds: 50), (timer) {
                              if (!_isPlaying) timer.cancel();
                              _movePlayer(10);
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(Icons.arrow_right, size: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
          },
        ),
      ),
    );
  }

  List<Widget> _buildClouds() {
    return [
      Positioned(left: 30, top: 80, child: _buildCloud(60)),
      Positioned(right: 50, top: 120, child: _buildCloud(80)),
      Positioned(left: 150, top: 60, child: _buildCloud(50)),
    ];
  }

  Widget _buildCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
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
    );
  }
}

/// 잔디 페인터
class GrassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF388E3C);
    final random = Random(42);

    for (double x = 0; x < size.width; x += 8) {
      final height = 5 + random.nextDouble() * 10;
      canvas.drawRect(
        Rect.fromLTWH(x, 0, 4, height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
