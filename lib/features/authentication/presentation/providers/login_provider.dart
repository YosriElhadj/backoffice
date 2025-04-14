import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/error_handler_provider.dart';
import '../../data/services/auth_service.dart';
import 'auth_provider.dart';

class LoginState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthService _authService;
  final Ref _ref;

  LoginNotifier(this._authService, this._ref) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authService.login(email, password);
      
      if (result['requiresTwoFactor']) {
        // Handle two-factor authentication
        state = state.copyWith(
          isLoading: false,
          error: 'Two-factor authentication required'
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true
        );
      }
    } catch (e) {
      _ref.read(errorHandlerProvider.notifier).handleError(e);
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
      state = LoginState();
    } catch (e) {
      _ref.read(errorHandlerProvider.notifier).handleError(e);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return LoginNotifier(authService, ref);
});