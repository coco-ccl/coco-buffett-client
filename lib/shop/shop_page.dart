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
      backgroundColor: const Color(0xFFF5F5DC), // 베이지 배경
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shopping_bag, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('캐릭터 상점', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: const Color(0xFF4169E1), // 로얄 블루
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: '얼굴'),
                Tab(text: '헤어'),
                Tab(text: '상의'),
                Tab(text: '하의'),
                Tab(text: '신발'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // 캐릭터 미리보기
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4169E1),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Text(
                    '미리보기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _CharacterPreview(),
              ],
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
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180, // 아이템 최대 너비
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
    return GestureDetector(
      onTap: () {
        onSelect(item);
        _showPurchaseSnackBar(item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘 영역
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F2FF),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Icon(
                _getIconForItem(item),
                size: 32,
                color: const Color(0xFF4169E1),
              ),
            ),
            const SizedBox(height: 8),
            // 아이템 이름
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            // 가격
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: item.price == 0 ? const Color(0xFF90EE90) : const Color(0xFFFFD700),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                item.price == 0 ? '무료' : '${item.price}G',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // 착용/구매 버튼
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF4169E1),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onSelect(item);
                    _showPurchaseSnackBar(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      item.price == 0 ? '착용' : '구매',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              '${item.name}을(를) 착용했습니다!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF4169E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(color: Colors.black, width: 2),
        ),
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
            color: const Color(0xFFF0F0F0),
            border: Border.all(color: Colors.black, width: 3),
          ),
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
                      color: Color(0xFF4169E1),
                      strokeWidth: 3,
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
