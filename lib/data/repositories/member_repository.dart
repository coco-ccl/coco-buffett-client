import '../api/api_client.dart';
import '../models/member_info_response.dart';

/// Member Repository - 회원 정보 데이터 관리
class MemberRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  MemberRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 현재 로그인한 회원 정보 조회
  Future<MemberInfo> getCurrentMemberInfo() async {
    if (_useMockData) {
      return _getMockMemberInfo();
    }

    final response = await _apiClient.getMemberInfo();
    if (response.code == 0 && response.data != null) {
      return _convertToMemberInfo(response.data!);
    }

    throw Exception('Failed to load member info');
  }

  /// DTO를 도메인 모델로 변환
  MemberInfo _convertToMemberInfo(MemberInfoResponse response) {
    return MemberInfo(
      memberNo: response.memberNo,
      id: response.id,
      nickname: response.nickname,
      profileImageUrl: response.profileImageUrl,
    );
  }

  /// Mock 데이터 반환
  MemberInfo _getMockMemberInfo() {
    return const MemberInfo(
      memberNo: 12345,
      id: 'cocobuffett_user',
      nickname: '코코버핏',
      profileImageUrl: null,
    );
  }
}

/// 회원 정보 도메인 모델
class MemberInfo {
  final int memberNo;
  final String id;
  final String nickname;
  final String? profileImageUrl;

  const MemberInfo({
    required this.memberNo,
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });
}
