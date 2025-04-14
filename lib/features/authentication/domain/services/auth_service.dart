import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

class AuthService {
  Future<UserModel?> login(String email, String password) async {
    // Simulated login - replace with actual backend call
    if (email == 'admin@theboost.com' && password == 'admin123') {
      return UserModel(
        id: '1',
        email: email,
        name: 'Admin User',
        role: 'admin',
      );
    }
    return null;
  }

  Future<void> logout() async {
    // Implement logout logic
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});