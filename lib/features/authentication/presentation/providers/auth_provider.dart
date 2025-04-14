import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/auth_service.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authService.login(email, password);
      state = state.copyWith(
        isLoading: false, 
        isAuthenticated: true
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        isAuthenticated: false,
        error: e.toString()
      );
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      state = state.copyWith(
        isAuthenticated: false, 
        error: null
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString()
      );
    }
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    state = state.copyWith(isAuthenticated: isLoggedIn);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});