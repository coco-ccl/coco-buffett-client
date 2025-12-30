import '../api/api_client.dart';
import '../models/member_info_response.dart';

/// Member Repository - 회원 정보 데이터 관리
class MemberRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  // 현재 로그인한 회원 정보 캐시
  MemberInfo? _currentMemberInfo;

  MemberRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 현재 로그인한 회원 정보 가져오기 (캐시된 값)
  MemberInfo? get currentMemberInfo => _currentMemberInfo;

  /// 현재 로그인한 memberId 가져오기
  String? get currentMemberId => _currentMemberInfo?.id;

  /// 현재 로그인한 nickname 가져오기
  String? get currentNickname => _currentMemberInfo?.nickname;

  /// 현재 로그인한 회원 정보 조회 및 저장
  Future<MemberInfo> loadCurrentMemberInfo() async {
    MemberInfo memberInfo;

    if (_useMockData) {
      memberInfo = _getMockMemberInfo();
    } else {
      final response = await _apiClient.getMemberInfo();
      if (response.code == 0 && response.data != null) {
        memberInfo = _convertToMemberInfo(response.data!);
      } else {
        throw Exception('Failed to load member info');
      }
    }

    // 캐시에 저장
    _currentMemberInfo = memberInfo;
    return memberInfo;
  }

  /// 회원 정보 초기화 (로그아웃 시)
  void clearMemberInfo() {
    _currentMemberInfo = null;
  }

  /// DTO를 도메인 모델로 변환
  MemberInfo _convertToMemberInfo(MemberInfoResponse response) {
    return MemberInfo(
      id: response.id,
      nickname: response.nickname,
      profileImageUrl: response.profileImageUrl,
    );
  }

  /// Mock 데이터 반환
  MemberInfo _getMockMemberInfo() {
    return const MemberInfo(
      id: 'cocobuffett_user',
      nickname: '코코버핏',
      profileImageUrl: null,
    );
  }
}

/// 회원 정보 도메인 모델
class MemberInfo {
  final String id;
  final String nickname;
  final String? profileImageUrl;

  const MemberInfo({
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });
}
