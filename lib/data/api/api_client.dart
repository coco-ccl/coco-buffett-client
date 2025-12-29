import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/member_info_response.dart';
import '../models/member_stock_response.dart';
import '../models/tradable_stock_response.dart';
import '../models/trade_stock_request.dart';
import '../models/item_response.dart';
import '../models/equipped_item_response.dart';
import '../models/purchase_item_request.dart';
import '../models/purchase_item_response.dart';
import '../models/signup_request.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

/// API Client - 서버 통신 담당
class ApiClient {
  late final Dio _dio;
  final String baseUrl;
  String? _accessToken; // 인증 토큰

  ApiClient({
    this.baseUrl = 'http://ec2-13-124-186-147.ap-northeast-2.compute.amazonaws.com:8080',
    String? accessToken,
  }) : _accessToken = accessToken {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 인터셉터 추가 (로깅, 에러 핸들링, 인증 등)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Authorization 헤더 추가
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('[API] $obj'),
      ),
    );
  }

  /// 액세스 토큰 설정
  void setAccessToken(String token) {
    _accessToken = token;
  }

  /// 현재 로그인한 회원 정보 조회
  /// GET /cocobuffett/v1/members/me
  Future<ApiResponse<MemberInfoResponse>> getMemberInfo() async {
    try {
      final response = await _dio.get('/cocobuffett/v1/members/me');

      return ApiResponse.fromJson(
        response.data,
        (json) => MemberInfoResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 회원 주식 정보 조회
  /// GET /cocobuffett/v1/members/{memberId}/stocks
  Future<ApiResponse<MemberStockResponse>> getMemberStocks(String memberId) async {
    try {
      final response = await _dio.get('/cocobuffett/v1/members/$memberId/stocks');

      return ApiResponse.fromJson(
        response.data,
        (json) => MemberStockResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 거래 가능 주식 리스트 조회
  /// GET /cocobuffett/v1/stocks/list
  Future<ApiResponse<List<TradableStockResponse>>> getTradableStocks() async {
    try {
      final response = await _dio.get('/cocobuffett/v1/stocks/list');

      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => TradableStockResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 주식 거래 (매수/매도)
  /// POST /cocobuffett/v1/stocks/trade
  Future<ApiResponse<dynamic>> tradeStock(TradeStockRequest request) async {
    try {
      final response = await _dio.post(
        '/cocobuffett/v1/stocks/trade',
        data: request.toJson(),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 아이템 리스트 조회
  /// GET /cocobuffett/v1/items/list
  Future<ApiResponse<List<ItemResponse>>> getItems() async {
    try {
      final response = await _dio.get('/cocobuffett/v1/items/list');

      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => ItemResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 내가 보유한 아이템 조회
  /// GET /cocobuffett/v1/items/owned/me
  Future<ApiResponse<List<ItemResponse>>> getOwnedItems() async {
    try {
      final response = await _dio.get('/cocobuffett/v1/items/owned/me');

      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => ItemResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 현재 착용한 아이템 조회
  /// GET /cocobuffett/v1/items/equipped
  Future<ApiResponse<List<EquippedItemResponse>>> getEquippedItems() async {
    try {
      final response = await _dio.get('/cocobuffett/v1/items/equipped');

      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => EquippedItemResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 아이템 구매
  /// POST /cocobuffett/v1/items/purchase
  Future<ApiResponse<PurchaseItemResponse>> purchaseItem(String itemId) async {
    try {
      final request = PurchaseItemRequest(itemId: itemId);
      final response = await _dio.post(
        '/cocobuffett/v1/items/purchase',
        data: request.toJson(),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => PurchaseItemResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 회원가입
  /// POST /cocobuffett/v1/members/signup
  Future<ApiResponse<dynamic>> signup(SignupRequest request) async {
    try {
      final response = await _dio.post(
        '/cocobuffett/v1/members/signup',
        data: request.toJson(),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 로그인
  /// POST /cocobuffett/v1/members/signin
  Future<ApiResponse<LoginResponse>> signin(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/cocobuffett/v1/members/signin',
        data: request.toJson(),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DioException 에러 핸들링
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('연결 시간이 초과되었습니다.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? '알 수 없는 오류가 발생했습니다.';
        return ApiException('서버 오류 ($statusCode): $message');
      case DioExceptionType.cancel:
        return ApiException('요청이 취소되었습니다.');
      case DioExceptionType.connectionError:
        return ApiException('네트워크 연결을 확인해주세요.');
      default:
        return ApiException('알 수 없는 오류가 발생했습니다: ${error.message}');
    }
  }
}

/// API Exception
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
