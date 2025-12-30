import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/member_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// Auth BLoC - 인증 관련 비즈니스 로직
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final MemberRepository _memberRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required MemberRepository memberRepository,
  })  : _authRepository = authRepository,
        _memberRepository = memberRepository,
        super(const AuthState.initial()) {
    on<_LoginRequested>(_onLoginRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    try {
      // 1. 로그인 (Bearer 토큰 획득)
      await _authRepository.login(
        memberId: event.memberId,
        password: event.password,
      );

      // 2. 회원 정보 조회 및 저장
      await _memberRepository.loadCurrentMemberInfo();

      emit(const AuthState.success());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // 로그아웃 처리
    _authRepository.logout();
    _memberRepository.clearMemberInfo();

    emit(const AuthState.initial());
  }
}
