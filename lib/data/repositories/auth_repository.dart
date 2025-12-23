import '../api/api_client.dart';
import '../models/signup_request.dart';
import '../models/login_request.dart';

/// Auth Repository - 인증 관련 데이터 관리
class AuthRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  AuthRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData {
    print('[AuthRepository] 생성됨 - useMockData: $_useMockData');
  }

  /// 회원가입
  Future<void> signup({
    required String memberId,
    required String password,
    required String nickname,
  }) async {
    print('[AuthRepository] 회원가입 시작: memberId=$memberId, nickname=$nickname');

    if (_useMockData) {
      // Mock 모드: 딜레이 후 성공
      await Future.delayed(const Duration(milliseconds: 1000));
      print('[AuthRepository] 회원가입 성공 (Mock)');
      return;
    }

    final request = SignupRequest(
      memberId: memberId,
      password: password,
      nickname: nickname,
    );

    final response = await _apiClient.signup(request);
    if (response.code != 0) {
      print('[AuthRepository] 회원가입 실패: ${response.message}');
      throw Exception(response.message);
    }

    print('[AuthRepository] 회원가입 성공');
  }

  /// 로그인
  Future<String> login({
    required String memberId,
    required String password,
  }) async {
    print('[AuthRepository] 로그인 시작: memberId=$memberId');

    if (_useMockData) {
      // Mock 모드: 딜레이 후 mock 토큰 반환
      await Future.delayed(const Duration(milliseconds: 1000));
      print('[AuthRepository] 로그인 성공 (Mock): token=mock_access_token_123');
      return 'mock_access_token_123';
    }

    final request = LoginRequest(
      memberId: memberId,
      password: password,
    );

    final response = await _apiClient.signin(request);
    if (response.code != 0) {
      print('[AuthRepository] 로그인 실패: ${response.message}');
      throw Exception(response.message);
    }

    // 액세스 토큰을 ApiClient에 설정
    final accessToken = response.data!.accessToken;
    _apiClient.setAccessToken(accessToken);

    final tokenPreview = accessToken.length > 20
        ? '${accessToken.substring(0, 20)}...'
        : accessToken;
    print('[AuthRepository] 로그인 성공: token=$tokenPreview');
    return accessToken;
  }

  /// 로그아웃
  void logout() {
    print('[AuthRepository] 로그아웃 처리');
    // ApiClient의 토큰 초기화
    _apiClient.setAccessToken('');
    print('[AuthRepository] 로그아웃 완료 - 토큰 초기화됨');
  }
}
