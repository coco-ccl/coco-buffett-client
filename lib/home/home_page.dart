import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../game/coco_game.dart';
import '../game/player_bloc/player_bloc.dart';
import '../auth/auth_bloc/auth_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/member_repository.dart';
import '../data/repositories/asset_repository.dart';
import '../data/repositories/item_repository.dart';
import '../data/repositories/stock_repository.dart';
import '../services/bgm_service.dart';

/// HomePage Wrapper - AuthBloc 제공
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: context.read<AuthRepository>(),
        memberRepository: context.read<MemberRepository>(),
      ),
      child: const _HomePageContent(),
    );
  }
}

/// HomePage 실제 내용
class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePageContent> {
  late final CocoGame game;
  bool _isGameInitialized = false;
  bool _isBgmStarted = false;
  final BgmService _bgmService = BgmService();

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

  @override
  void dispose() {
    _bgmService.stop();
    super.dispose();
  }

  void _startBgm() {
    if (!_isBgmStarted) {
      _isBgmStarted = true;
      _bgmService.play();
    }
  }

  Future<void> _initializeRepositories() async {
    final memberRepo = context.read<MemberRepository>();
    final assetRepo = context.read<AssetRepository>();
    final itemRepo = context.read<ItemRepository>();
    final stockRepo = context.read<StockRepository>();

    // MemberRepository에서 memberId 가져오기
    final memberId = memberRepo.currentMemberId;
    if (memberId == null) {
      throw Exception('로그인 정보가 없습니다. memberId가 null입니다.');
    }

    // 모든 Repository 초기화 (한 번만)
    await Future.wait([
      assetRepo.initialize(memberId: memberId),
      itemRepo.initialize(),
      stockRepo.initialize(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeRepositories(),
      builder: (context, snapshot) {
        // 로딩 중
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('데이터를 불러오는 중...'),
                ],
              ),
            ),
          );
        }

        // 에러 발생
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text('데이터 로드 실패: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            ),
          );
        }

        // 초기화 완료 - BGM 재생 및 홈 화면 표시
        _startBgm();
        return _buildHomePage();
      },
    );
  }

  Widget _buildHomePage() {
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
          // 로그아웃 버튼
          Positioned(
            top: 230,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'logout_button',
              onPressed: () => _showLogoutDialog(context),
              backgroundColor: const Color(0xFFE74C3C),
              child: const Icon(Icons.logout),
            ),
          ),
          // 미니게임 버튼
          Positioned(
            top: 300,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'minigame_button',
              onPressed: () => context.push('/minigame'),
              backgroundColor: const Color(0xFFFF6B6B),
              child: const Icon(Icons.gamepad),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5DC), // 베이지 배경
            border: Border.all(color: Colors.black, width: 3),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 제목
              const Text(
                '로그아웃',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              // 메시지
              const Text(
                '로그아웃 하시겠습니까?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 취소 버튼
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 확인 버튼
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE74C3C),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // 로그아웃 처리 - AuthBloc에 이벤트 전송
                          context.read<AuthBloc>().add(const AuthEvent.logoutRequested());

                          // 다이얼로그 닫기
                          Navigator.of(dialogContext).pop();

                          // 회원가입 화면으로 이동 (스택 초기화)
                          context.go('/signup');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

