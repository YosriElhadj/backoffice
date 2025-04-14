import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_model.dart';
import '../../domain/services/auth_service.dart';

// Authentication state class
class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  // Convenience constructors
  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Authentication Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

  Future<void> login(String email, String password) async {
    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Attempt login
      final user = await _authService.login(email, password);
      
      if (user != null) {
        // Successful login
        state = state.copyWith(
          user: user, 
          isLoading: false,
          error: null
        );
      } else {
        // Failed login
        state = state.copyWith(
          user: null, 
          isLoading: false,
          error: 'Invalid credentials'
        );
      }
    } catch (e) {
      // Error handling
      state = state.copyWith(
        user: null, 
        isLoading: false,
        error: e.toString()
      );
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState(); // Reset to initial state
  }
}

// Providers
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});