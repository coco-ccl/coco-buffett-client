import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../game/player_bloc/player_bloc.dart';
import '../game/sprite_layers.dart';
import '../game/sprites/bottom.dart';
import '../game/sprites/face.dart';
import '../game/sprites/hair.dart';
import '../game/sprites/shoes.dart';
import '../game/sprites/top.dart';
import '../data/repositories/item_repository.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map<String, List<GameItem>> _itemsByCategory = {};
  Set<String> _equippedItemIds = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadItems();
  }

  Future<void> _loadItems() async {
    print('[InventoryPage] 아이템 로딩 시작');
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final itemRepository = RepositoryProvider.of<ItemRepository>(context, listen: false);

      // 보유 아이템과 착용 아이템 동시 조회
      final results = await Future.wait([
        itemRepository.getOwnedItems(),
        itemRepository.getEquippedItems(),
      ]);

      final ownedItems = results[0] as List<GameItem>;
      final equippedItems = results[1] as List<EquippedItem>;

      print('[InventoryPage] 보유 아이템: ${ownedItems.length}개, 착용 아이템: ${equippedItems.length}개');

      // 카테고리별로 그룹핑
      final itemsByCategory = <String, List<GameItem>>{
        '얼굴': [],
        '헤어': [],
        '상의': [],
        '하의': [],
        '신발': [],
      };

      for (final item in ownedItems) {
        final category = _getCategoryName(item.type);
        if (itemsByCategory.containsKey(category)) {
          itemsByCategory[category]!.add(item);
        }
      }

      // 착용 아이템 ID 세트 구성
      final equippedItemIds = equippedItems.map((item) => item.itemId).toSet();

      setState(() {
        _itemsByCategory = itemsByCategory;
        _equippedItemIds = equippedItemIds;
        _isLoading = false;
      });

      print('[InventoryPage] 아이템 로딩 완료');
    } catch (e) {
      print('[InventoryPage] 아이템 로딩 실패: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = '아이템을 불러오는데 실패했습니다: $e';
      });
    }
  }

  String _getCategoryName(String type) {
    switch (type) {
      case 'face':
        return '얼굴';
      case 'hair':
        return '헤어';
      case 'top':
        return '상의';
      case 'bottom':
        return '하의';
      case 'shoes':
        return '신발';
      default:
        return type;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // 베이지 배경
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.inventory, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('인벤토리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        backgroundColor: const Color(0xFF4A90E2), // 모던 블루
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4A90E2),
                strokeWidth: 3,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(fontSize: 14, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadItems,
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                )
              : BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    // 현재 착용 중인 아이템 업데이트
                    _updateEquippedStatus(state.data);

                    return Column(
                      children: [
                        // 캐릭터 미리보기
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(8),
                          child: ClipPath(
                            clipper: _PixelClipper(notchSize: 6),
                            child: CustomPaint(
                              painter: _PixelBorderPainter(
                                borderColor: Colors.black,
                                borderWidth: 3,
                                notchSize: 6,
                                has3DEffect: true,
                              ),
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    ClipPath(
                                      clipper: _PixelClipper(notchSize: 3),
                                      child: CustomPaint(
                                        painter: _PixelBorderPainter(
                                          borderColor: Colors.black,
                                          borderWidth: 2,
                                          notchSize: 3,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          color: const Color(0xFF4A90E2),
                                          child: const Text(
                                            '내 캐릭터',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _CharacterPreview(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 아이템 그리드
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildItemGrid('얼굴'),
                              _buildItemGrid('헤어'),
                              _buildItemGrid('상의'),
                              _buildItemGrid('하의'),
                              _buildItemGrid('신발'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
    );
  }

  void _updateEquippedStatus(PlayerData data) {
    // PlayerBloc의 state를 기반으로 착용 중인 아이템 ID를 업데이트
    final newEquippedIds = {
      data.faceId,
      data.hairId,
      data.topId,
      data.bottomId,
      data.shoesId,
    };

    if (!_equippedItemIds.containsAll(newEquippedIds) ||
        !newEquippedIds.containsAll(_equippedItemIds)) {
      setState(() {
        _equippedItemIds = newEquippedIds;
      });
    }
  }

  Widget _buildItemGrid(String category) {
    final items = _itemsByCategory[category] ?? [];

    if (items.isEmpty) {
      return Center(
        child: Text(
          '보유한 $category 아이템이 없습니다',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItemCard(item, category);
      },
    );
  }

  Widget _buildItemCard(GameItem item, String category) {
    final playerBloc = context.read<PlayerBloc>();
    final isEquipped = _equippedItemIds.contains(item.itemId);

    return GestureDetector(
      onTap: () {
        // 착용
        switch (category) {
          case '얼굴':
            playerBloc.add(PlayerEvent.faceChanged(item.itemId));
            break;
          case '헤어':
            playerBloc.add(PlayerEvent.hairChanged(item.itemId));
            break;
          case '상의':
            playerBloc.add(PlayerEvent.topChanged(item.itemId));
            break;
          case '하의':
            playerBloc.add(PlayerEvent.bottomChanged(item.itemId));
            break;
          case '신발':
            playerBloc.add(PlayerEvent.shoesChanged(item.itemId));
            break;
        }
        _showEquipSnackBar(item);
      },
      child: ClipPath(
        clipper: _PixelClipper(notchSize: 4),
        child: CustomPaint(
          painter: _PixelBorderPainter(
            borderColor: isEquipped ? const Color(0xFF4A90E2) : Colors.black,
            borderWidth: isEquipped ? 4 : 3,
            notchSize: 4,
            has3DEffect: true,
          ),
          child: Container(
            color: isEquipped ? const Color(0xFFE6F2FF) : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아이템 아이콘
                ClipPath(
                  clipper: _PixelClipper(notchSize: 3),
                  child: CustomPaint(
                    painter: _PixelBorderPainter(
                      borderColor: Colors.black,
                      borderWidth: 2,
                      notchSize: 3,
                      has3DEffect: true,
                    ),
                    child: Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFFF0F0F0),
                      child: _ItemIconPreview(
                        itemId: item.itemId,
                        category: category,
                      ),
                    ),
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
                // 착용 상태
                if (isEquipped)
                  ClipPath(
                    clipper: _PixelClipper(notchSize: 2),
                    child: CustomPaint(
                      painter: _PixelBorderPainter(
                        borderColor: Colors.black,
                        borderWidth: 2,
                        notchSize: 2,
                        has3DEffect: true,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        color: const Color(0xFF90EE90),
                        child: const Text(
                          '착용 중',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEquipSnackBar(GameItem item) {
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
        backgroundColor: const Color(0xFF4A90E2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}

/// 픽셀 스타일 모서리를 만드는 커스텀 클리퍼
class _PixelClipper extends CustomClipper<Path> {
  final double notchSize;

  _PixelClipper({this.notchSize = 4.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(notchSize, 0);
    path.lineTo(size.width - notchSize, 0);
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width, notchSize);
    path.lineTo(size.width, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height);
    path.lineTo(notchSize, size.height);
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(0, size.height - notchSize);
    path.lineTo(0, notchSize);
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_PixelClipper oldClipper) => notchSize != oldClipper.notchSize;
}

/// 픽셀 스타일 테두리를 그리는 페인터
class _PixelBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double notchSize;
  final bool has3DEffect;

  _PixelBorderPainter({
    required this.borderColor,
    this.borderWidth = 3.0,
    this.notchSize = 4.0,
    this.has3DEffect = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path();
    path.moveTo(notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width - borderWidth / 2, notchSize);
    path.lineTo(size.width - borderWidth / 2, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(borderWidth / 2, size.height - notchSize);
    path.lineTo(borderWidth / 2, notchSize);
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, borderWidth / 2);

    canvas.drawPath(path, paint);

    // 3D 베벨 효과
    if (has3DEffect) {
      final bevelWidth = borderWidth + 2;

      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      final topBevel = Path();
      topBevel.moveTo(notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize - bevelWidth, borderWidth + bevelWidth);
      topBevel.lineTo(notchSize + bevelWidth, borderWidth + bevelWidth);
      topBevel.close();
      canvas.drawPath(topBevel, highlightPaint);

      final leftBevel = Path();
      leftBevel.moveTo(borderWidth, notchSize);
      leftBevel.lineTo(borderWidth + bevelWidth, notchSize + bevelWidth);
      leftBevel.lineTo(borderWidth + bevelWidth, size.height - notchSize - bevelWidth);
      leftBevel.lineTo(borderWidth, size.height - notchSize);
      leftBevel.close();
      canvas.drawPath(leftBevel, highlightPaint);

      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;

      final bottomBevel = Path();
      bottomBevel.moveTo(notchSize + bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize - bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize, size.height - borderWidth);
      bottomBevel.lineTo(notchSize, size.height - borderWidth);
      bottomBevel.close();
      canvas.drawPath(bottomBevel, shadowPaint);

      final rightBevel = Path();
      rightBevel.moveTo(size.width - borderWidth - bevelWidth, notchSize + bevelWidth);
      rightBevel.lineTo(size.width - borderWidth, notchSize);
      rightBevel.lineTo(size.width - borderWidth, size.height - notchSize);
      rightBevel.lineTo(size.width - borderWidth - bevelWidth, size.height - notchSize - bevelWidth);
      rightBevel.close();
      canvas.drawPath(rightBevel, shadowPaint);
    }
  }

  @override
  bool shouldRepaint(_PixelBorderPainter oldDelegate) =>
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      notchSize != oldDelegate.notchSize ||
      has3DEffect != oldDelegate.has3DEffect;
}

/// 아이템 아이콘 미리보기
class _ItemIconPreview extends StatefulWidget {
  final String itemId;
  final String category;

  const _ItemIconPreview({
    required this.itemId,
    required this.category,
  });

  @override
  State<_ItemIconPreview> createState() => _ItemIconPreviewState();
}

class _ItemIconPreviewState extends State<_ItemIconPreview> {
  ui.Image? _cachedImage;
  String? _lastItemId;

  @override
  void initState() {
    super.initState();
    _loadItemImage();
  }

  @override
  void didUpdateWidget(_ItemIconPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemId != widget.itemId) {
      _loadItemImage();
    }
  }

  Future<void> _loadItemImage() async {
    if (_lastItemId == widget.itemId && _cachedImage != null) {
      return;
    }

    _lastItemId = widget.itemId;

    try {
      final image = await _generateSinglePartImage(
        category: widget.category,
        itemId: widget.itemId,
      );

      if (mounted) {
        setState(() {
          _cachedImage?.dispose();
          _cachedImage = image;
        });
      }
    } catch (e) {
      debugPrint('Failed to load item icon: $e');
    }
  }

  Future<ui.Image> _generateSinglePartImage({
    required String category,
    required String itemId,
  }) async {
    List<List<Color>> pixels;

    switch (category) {
      case '얼굴':
        pixels = FaceSprites.getPixels(Direction.down, itemId);
        break;
      case '헤어':
        pixels = HairSprites.getPixels(Direction.down, itemId);
        break;
      case '상의':
        pixels = TopSprites.getPixels(Direction.down, itemId);
        break;
      case '하의':
        pixels = BottomSprites.getPixels(Direction.down, itemId);
        break;
      case '신발':
        pixels = ShoesSprites.getPixels(Direction.down, itemId);
        break;
      default:
        throw Exception('Unknown category: $category');
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    for (int y = 0; y < 32; y++) {
      for (int x = 0; x < 32; x++) {
        final color = pixels[y][x];
        if (color.alpha > 0) {
          final paint = Paint()..color = color;
          canvas.drawRect(
            Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
            paint,
          );
        }
      }
    }

    final picture = recorder.endRecording();
    return await picture.toImage(32, 32);
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedImage == null) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF4A90E2),
          ),
        ),
      );
    }

    return CustomPaint(
      size: const Size(64, 64),
      painter: _CharacterPainter(_cachedImage!),
    );
  }

  @override
  void dispose() {
    _cachedImage?.dispose();
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

/// 전신 캐릭터 미리보기
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

        return ClipPath(
          clipper: _PixelClipper(notchSize: 4),
          child: CustomPaint(
            painter: _PixelBorderPainter(
              borderColor: Colors.black,
              borderWidth: 3,
              notchSize: 4,
            ),
            child: Container(
              width: 128,
              height: 128,
              color: const Color(0xFFF0F0F0),
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
                        color: Color(0xFF4A90E2),
                        strokeWidth: 3,
                      ),
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
