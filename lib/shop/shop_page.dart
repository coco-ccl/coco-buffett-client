import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../asset/asset_bloc/asset_bloc.dart';
import '../game/player_bloc/player_bloc.dart';
import '../game/sprite_layers.dart';
import '../game/sprites/bottom.dart';
import '../game/sprites/face.dart';
import '../game/sprites/hair.dart';
import '../game/sprites/shoes.dart';
import '../game/sprites/top.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // 베이지 배경
      appBar: AppBar(
        title: const Text('캐릭터 상점', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF4A90E2), // 모던 블루
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          // 자산 표시
          BlocBuilder<AssetBloc, AssetState>(
            builder: (context, state) {
              final numberFormat = NumberFormat('#,###');
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Color(0xFFFFD700), size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '${numberFormat.format(state.data.deposit)} G',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          final playerBloc = context.read<PlayerBloc>();

          return Column(
            children: [
              // 캐릭터 미리보기
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(8),
                child: ClipPath(
                  clipper: PixelClipper(notchSize: 6),
                  child: CustomPaint(
                    painter: PixelBorderPainter(
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
                            clipper: PixelClipper(notchSize: 3),
                            child: CustomPaint(
                              painter: PixelBorderPainter(
                                borderColor: Colors.black,
                                borderWidth: 2,
                                notchSize: 3,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                color: const Color(0xFF4A90E2),
                                child: const Text(
                                  '미리보기',
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
                    _buildItemGrid('얼굴', state.data, (item) => playerBloc.add(PlayerEvent.faceChanged(item.id))),
                    _buildItemGrid('헤어', state.data, (item) => playerBloc.add(PlayerEvent.hairChanged(item.id))),
                    _buildItemGrid('상의', state.data, (item) => playerBloc.add(PlayerEvent.topChanged(item.id))),
                    _buildItemGrid('하의', state.data, (item) => playerBloc.add(PlayerEvent.bottomChanged(item.id))),
                    _buildItemGrid('신발', state.data, (item) => playerBloc.add(PlayerEvent.shoesChanged(item.id))),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemGrid(String category, PlayerData playerData, void Function(ShopItem) onSelect) {
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
        return _buildItemCard(item, category, playerData, onSelect);
      },
    );
  }

  Widget _buildItemCard(ShopItem item, String category, PlayerData playerData, void Function(ShopItem) onSelect) {
    // 현재 착용 중인 아이템인지 확인
    bool isEquipped = false;
    switch (category) {
      case '얼굴':
        isEquipped = item.id == playerData.faceId;
        break;
      case '헤어':
        isEquipped = item.id == playerData.hairId;
        break;
      case '상의':
        isEquipped = item.id == playerData.topId;
        break;
      case '하의':
        isEquipped = item.id == playerData.bottomId;
        break;
      case '신발':
        isEquipped = item.id == playerData.shoesId;
        break;
    }

    return GestureDetector(
      onTap: () {
        _handleItemSelect(context, item, onSelect);
      },
      child: ClipPath(
        clipper: PixelClipper(notchSize: 4),
        child: CustomPaint(
          painter: PixelBorderPainter(
            borderColor: isEquipped ? const Color(0xFF4A90E2) : Colors.black,
            borderWidth: isEquipped ? 4 : 3,
            notchSize: 4,
            has3DEffect: true, // 3D 효과 활성화
          ),
          child: Container(
            color: isEquipped ? const Color(0xFFE6F2FF) : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아이콘 영역
                ClipPath(
                  clipper: PixelClipper(notchSize: 3),
                  child: CustomPaint(
                    painter: PixelBorderPainter(
                      borderColor: Colors.black,
                      borderWidth: 2,
                      notchSize: 3,
                      has3DEffect: true,
                    ),
                    child: Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFFE6F2FF),
                      child: _ItemIconPreview(
                        item: item,
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
                // 가격 또는 착용 중 표시
                if (isEquipped)
                  ClipPath(
                    clipper: PixelClipper(notchSize: 2),
                    child: CustomPaint(
                      painter: PixelBorderPainter(
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
                  )
                else
                  ClipPath(
                    clipper: PixelClipper(notchSize: 2),
                    child: CustomPaint(
                      painter: PixelBorderPainter(
                        borderColor: Colors.black,
                        borderWidth: 2,
                        notchSize: 2,
                        has3DEffect: true,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        color: item.price == 0 ? const Color(0xFF90EE90) : const Color(0xFFFFD700),
                        child: Text(
                          item.price == 0 ? '무료' : '${item.price}G',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 6),
                // 착용/구매 버튼
                if (!isEquipped)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: ClipPath(
                      clipper: PixelClipper(notchSize: 2),
                      child: CustomPaint(
                        painter: PixelBorderPainter(
                          borderColor: Colors.black,
                          borderWidth: 2,
                          notchSize: 2,
                          has3DEffect: true,
                        ),
                        child: Material(
                          color: const Color(0xFF4A90E2),
                          child: InkWell(
                            onTap: () {
                              _handleItemSelect(context, item, onSelect);
                            },
                            child: Container(
                              width: double.infinity,
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
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleItemSelect(BuildContext context, ShopItem item, void Function(ShopItem) onSelect) {
    final assetBloc = context.read<AssetBloc>();

    // 잔액 확인
    if (item.price > 0 && assetBloc.state.data.deposit < item.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                '잔액이 부족합니다!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 아이템 착용/구매
    onSelect(item);

    // 가격이 0이 아닌 경우 자산 차감
    if (item.price > 0) {
      assetBloc.add(AssetEvent.itemPurchased(
        itemName: item.name,
        price: item.price,
      ));
    }

    _showPurchaseSnackBar(item);
  }

  void _showPurchaseSnackBar(ShopItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              item.price > 0
                  ? '${item.name}을(를) 구매했습니다!'
                  : '${item.name}을(를) 착용했습니다!',
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

/// 픽셀 스타일 모서리를 만드는 커스텀 클리퍼
class PixelClipper extends CustomClipper<Path> {
  final double notchSize;

  PixelClipper({this.notchSize = 4.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    // 왼쪽 상단
    path.moveTo(notchSize, 0);
    path.lineTo(size.width - notchSize, 0);

    // 오른쪽 상단 노치
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width, notchSize);
    path.lineTo(size.width, size.height - notchSize);

    // 오른쪽 하단 노치
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height);
    path.lineTo(notchSize, size.height);

    // 왼쪽 하단 노치
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(0, size.height - notchSize);
    path.lineTo(0, notchSize);

    // 왼쪽 상단 노치
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(PixelClipper oldClipper) => notchSize != oldClipper.notchSize;
}

/// 픽셀 스타일 테두리를 그리는 페인터
class PixelBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double notchSize;
  final bool has3DEffect;

  PixelBorderPainter({
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

    // 왼쪽 상단
    path.moveTo(notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, borderWidth / 2);

    // 오른쪽 상단 노치
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width - borderWidth / 2, notchSize);
    path.lineTo(size.width - borderWidth / 2, size.height - notchSize);

    // 오른쪽 하단 노치
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - borderWidth / 2);

    // 왼쪽 하단 노치
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(borderWidth / 2, size.height - notchSize);
    path.lineTo(borderWidth / 2, notchSize);

    // 왼쪽 상단 노치
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, borderWidth / 2);

    canvas.drawPath(path, paint);

    // 3D 베벨 효과 추가 - 영역을 채워서 그리기
    if (has3DEffect) {
      final bevelWidth = borderWidth + 2;

      // 밝은 베벨 (왼쪽 + 상단)
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.7)
        ..style = PaintingStyle.fill;

      // 상단 베벨
      final topBevel = Path();
      topBevel.moveTo(notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize - bevelWidth, borderWidth + bevelWidth);
      topBevel.lineTo(notchSize + bevelWidth, borderWidth + bevelWidth);
      topBevel.close();
      canvas.drawPath(topBevel, highlightPaint);

      // 왼쪽 베벨
      final leftBevel = Path();
      leftBevel.moveTo(borderWidth, notchSize);
      leftBevel.lineTo(borderWidth + bevelWidth, notchSize + bevelWidth);
      leftBevel.lineTo(borderWidth + bevelWidth, size.height - notchSize - bevelWidth);
      leftBevel.lineTo(borderWidth, size.height - notchSize);
      leftBevel.close();
      canvas.drawPath(leftBevel, highlightPaint);

      // 어두운 베벨 (오른쪽 + 하단)
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.4)
        ..style = PaintingStyle.fill;

      // 하단 베벨
      final bottomBevel = Path();
      bottomBevel.moveTo(notchSize + bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize - bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize, size.height - borderWidth);
      bottomBevel.lineTo(notchSize, size.height - borderWidth);
      bottomBevel.close();
      canvas.drawPath(bottomBevel, shadowPaint);

      // 오른쪽 베벨
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
  bool shouldRepaint(PixelBorderPainter oldDelegate) =>
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      notchSize != oldDelegate.notchSize ||
      has3DEffect != oldDelegate.has3DEffect;
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

        return ClipPath(
          clipper: PixelClipper(notchSize: 4),
          child: CustomPaint(
            painter: PixelBorderPainter(
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

/// 아이템 아이콘 미리보기 - 실제 도트 그래픽 표시
class _ItemIconPreview extends StatefulWidget {
  final ShopItem item;
  final String category;

  const _ItemIconPreview({
    required this.item,
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
    if (oldWidget.item.id != widget.item.id) {
      _loadItemImage();
    }
  }

  Future<void> _loadItemImage() async {
    if (_lastItemId == widget.item.id && _cachedImage != null) {
      return; // 이미 로드된 이미지
    }

    _lastItemId = widget.item.id;

    try {
      final image = await _generateSinglePartImage(
        category: widget.category,
        itemId: widget.item.id,
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

  // 카테고리별 단일 파트 이미지 생성
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

    // 픽셀 그리기
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
            color: Color(0xFF4169E1),
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
