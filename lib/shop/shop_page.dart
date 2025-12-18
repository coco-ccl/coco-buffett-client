import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../game/player_bloc/player_bloc.dart';
import '../game/sprite_layers.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<ShopItem>> _shopItems = {
    '얼굴': [
      ShopItem(id: 'default', name: '기본', price: 0),
      ShopItem(id: 'cute', name: '귀여움', price: 100),
      ShopItem(id: 'cool', name: '멋짐', price: 100),
    ],
    '헤어': [
      ShopItem(id: 'short_brown', name: '짧은 갈색', price: 0),
      ShopItem(id: 'short_black', name: '짧은 검정', price: 150),
      ShopItem(id: 'short_blonde', name: '짧은 금발', price: 150),
      ShopItem(id: 'long_brown', name: '긴 갈색', price: 200),
      ShopItem(id: 'long_black', name: '긴 검정', price: 200),
      ShopItem(id: 'pomade_black', name: '포마드 검정', price: 250),
      ShopItem(id: 'pomade_brown', name: '포마드 갈색', price: 250),
      ShopItem(id: 'gray', name: '회색', price: 300),
    ],
    '상의': [
      ShopItem(id: 'tshirt_white', name: '흰색 티셔츠', price: 0),
      ShopItem(id: 'tshirt_blue', name: '파란 티셔츠', price: 100),
      ShopItem(id: 'tshirt_red', name: '빨간 티셔츠', price: 100),
      ShopItem(id: 'tshirt_green', name: '초록 티셔츠', price: 100),
      ShopItem(id: 'tshirt_flower', name: '꽃무늬 티셔츠', price: 200),
      ShopItem(id: 'shirt_white', name: '흰색 셔츠', price: 250),
    ],
    '하의': [
      ShopItem(id: 'pants_black', name: '검정 바지', price: 0),
      ShopItem(id: 'pants_navy', name: '네이비 바지', price: 150),
      ShopItem(id: 'pants_gray', name: '회색 바지', price: 150),
      ShopItem(id: 'jeans_blue', name: '파란 청바지', price: 200),
    ],
    '신발': [
      ShopItem(id: 'shoes_black', name: '검정 구두', price: 0),
      ShopItem(id: 'shoes_brown', name: '갈색 구두', price: 150),
      ShopItem(id: 'sneakers_white', name: '흰색 운동화', price: 200),
      ShopItem(id: 'sneakers_black', name: '검정 운동화', price: 200),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerBloc = context.read<PlayerBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shopping_bag, color: Colors.white),
            SizedBox(width: 8),
            Text('캐릭터 상점'),
          ],
        ),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.face), text: '얼굴'),
            Tab(icon: Icon(Icons.content_cut), text: '헤어'),
            Tab(icon: Icon(Icons.checkroom), text: '상의'),
            Tab(icon: Icon(Icons.accessibility), text: '하의'),
            Tab(icon: Icon(Icons.sports_soccer), text: '신발'),
          ],
        ),
      ),
      body: Column(
        children: [
          // 캐릭터 미리보기
          Container(
            height: 200,
            color: Colors.grey.shade100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '미리보기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _CharacterPreview(),
                ],
              ),
            ),
          ),
          // 아이템 그리드
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildItemGrid('얼굴', (item) => playerBloc.add(PlayerEvent.faceChanged(item.id))),
                _buildItemGrid('헤어', (item) => playerBloc.add(PlayerEvent.hairChanged(item.id))),
                _buildItemGrid('상의', (item) => playerBloc.add(PlayerEvent.topChanged(item.id))),
                _buildItemGrid('하의', (item) => playerBloc.add(PlayerEvent.bottomChanged(item.id))),
                _buildItemGrid('신발', (item) => playerBloc.add(PlayerEvent.shoesChanged(item.id))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemGrid(String category, void Function(ShopItem) onSelect) {
    final items = _shopItems[category] ?? [];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItemCard(item, onSelect);
      },
    );
  }

  Widget _buildItemCard(ShopItem item, void Function(ShopItem) onSelect) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          onSelect(item);
          _showPurchaseSnackBar(item);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconForItem(item),
                  size: 40,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on,
                    size: 16,
                    color: item.price == 0 ? Colors.green : Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.price == 0 ? '무료' : '${item.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: item.price == 0 ? Colors.green : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  onSelect(item);
                  _showPurchaseSnackBar(item);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(item.price == 0 ? '착용' : '구매'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForItem(ShopItem item) {
    if (item.id.contains('face') || item.id == 'default' || item.id == 'cute' || item.id == 'cool') {
      return Icons.sentiment_satisfied;
    } else if (item.id.contains('hair') || item.id.contains('short') || item.id.contains('long') || item.id.contains('pomade') || item.id == 'gray') {
      return Icons.face_retouching_natural;
    } else if (item.id.contains('tshirt') || item.id.contains('shirt')) {
      return Icons.checkroom;
    } else if (item.id.contains('pants') || item.id.contains('jeans')) {
      return Icons.accessibility_new;
    } else if (item.id.contains('shoes') || item.id.contains('sneakers')) {
      return Icons.sports_soccer;
    }
    return Icons.shopping_bag;
  }

  void _showPurchaseSnackBar(ShopItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name}을(를) 착용했습니다!'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}

class ShopItem {
  final String id;
  final String name;
  final int price;

  ShopItem({
    required this.id,
    required this.name,
    required this.price,
  });
}

class _CharacterPreview extends StatefulWidget {
  @override
  State<_CharacterPreview> createState() => _CharacterPreviewState();
}

class _CharacterPreviewState extends State<_CharacterPreview> {
  ui.Image? _currentImage;
  ui.Image? _previousImage;
  String? _lastKey;
  bool _isLoading = false;
  final List<ui.Image> _imagesToDispose = [];

  @override
  void initState() {
    super.initState();
    // 초기 이미지 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final playerBloc = context.read<PlayerBloc>();
      final data = playerBloc.state.data;
      final key = '${data.faceId}_${data.hairId}_${data.topId}_${data.bottomId}_${data.shoesId}';
      _lastKey = key;
      _loadImage(
        faceId: data.faceId,
        hairId: data.hairId,
        topId: data.topId,
        bottomId: data.bottomId,
        shoesId: data.shoesId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        final key = '${state.data.faceId}_${state.data.hairId}_${state.data.topId}_${state.data.bottomId}_${state.data.shoesId}';

        // 상태가 변경되었을 때만 이미지 재생성 (build 후에 실행)
        if (key != _lastKey) {
          _lastKey = key;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _loadImage(
              faceId: state.data.faceId,
              hairId: state.data.hairId,
              topId: state.data.topId,
              bottomId: state.data.bottomId,
              shoesId: state.data.shoesId,
            );
          });
        }

        return Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepOrange, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: _currentImage != null || _previousImage != null
                ? Stack(
                    children: [
                      // 이전 이미지를 배경으로 유지하여 깜빡임 방지
                      if (_previousImage != null)
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: CustomPaint(
                            size: const Size(128, 128),
                            painter: _CharacterPainter(_previousImage!),
                          ),
                        ),
                      // 현재 이미지를 위에 표시
                      if (_currentImage != null)
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: CustomPaint(
                            size: const Size(128, 128),
                            painter: _CharacterPainter(_currentImage!),
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                      strokeWidth: 3,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _loadImage({
    required String faceId,
    required String hairId,
    required String topId,
    required String bottomId,
    required String shoesId,
  }) async {
    if (!mounted) return;

    // 첫 로드가 아니면 이전 이미지 보존
    if (_currentImage != null) {
      setState(() {
        _isLoading = true;
        // 이전 이미지가 있으면 dispose 리스트에 추가
        if (_previousImage != null) {
          _imagesToDispose.add(_previousImage!);
        }
        _previousImage = _currentImage;
      });
    }

    try {
      final image = await SpriteLayerGenerator.generateLayeredImage(
        direction: Direction.down,
        faceId: faceId,
        hairId: hairId,
        topId: topId,
        bottomId: bottomId,
        shoesId: shoesId,
      );

      if (mounted) {
        setState(() {
          _currentImage = image;
          _isLoading = false;
        });

        // 새 이미지가 표시된 후 이전 이미지를 dispose 리스트로 이동
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted && _previousImage != null) {
            setState(() {
              _imagesToDispose.add(_previousImage!);
              _previousImage = null;
            });
            // 바로 dispose
            _disposeOldImages();
          }
        });
      }
    } catch (e) {
      debugPrint('Failed to load character image: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _disposeOldImages() {
    for (final image in _imagesToDispose) {
      image.dispose();
    }
    _imagesToDispose.clear();
  }

  @override
  void dispose() {
    _currentImage?.dispose();
    _previousImage?.dispose();
    _disposeOldImages();
    super.dispose();
  }
}

class _CharacterPainter extends CustomPainter {
  final ui.Image image;

  _CharacterPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..filterQuality = FilterQuality.none
      ..isAntiAlias = false;

    final srcRect = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawImageRect(image, srcRect, dstRect, paint);
  }

  @override
  bool shouldRepaint(_CharacterPainter oldDelegate) {
    return oldDelegate.image != image;
  }
}
