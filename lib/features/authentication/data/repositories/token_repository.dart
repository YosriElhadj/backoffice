import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth_service.dart';

class TokenRepository {
  final AuthService _authService;
  final FlutterSecureStorage _secureStorage;

  TokenRepository(this._authService, this._secureStorage);

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> refreshTokens() async {
    final refreshToken = await getRefreshToken();
    
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    try {
      final newTokens = await _authService.refreshTokens(refreshToken);
      
      await _secureStorage.write(
        key: 'access_token', 
        value: newTokens['accessToken']
      );
      
      await _secureStorage.write(
        key: 'refresh_token', 
        value: newTokens['refreshToken']
      );
    } catch (e) {
      // If refresh fails, logout the user
      await _secureStorage.deleteAll();
      throw Exception('Token refresh failed');
    }
  }
}