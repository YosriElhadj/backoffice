import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  

  static const _baseUrl = 'http://localhost:3000/graphql'; // Replace with actual URL

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Store tokens
        await _secureStorage.write(
          key: 'access_token', 
          value: response.data['accessToken']
        );
        await _secureStorage.write(
          key: 'refresh_token', 
          value: response.data['refreshToken']
        );

        return response.data;
      }
      throw Exception('Login failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> refreshTokens(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        return {
          'accessToken': response.data['accessToken'],
          'refreshToken': response.data['refreshToken']
        };
      }
      throw Exception('Token refresh failed');
    } catch (e) {
      throw Exception('Network error during token refresh');
    }
  }

  Future<void> logout() async {
    try {
      // Call backend logout endpoint
      await _dio.post('$_baseUrl/auth/logout');
      
      // Clear stored tokens
      await _secureStorage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }
}