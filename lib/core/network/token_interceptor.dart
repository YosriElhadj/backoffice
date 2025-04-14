import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler
  ) async {
    final token = await _secureStorage.read(key: 'access_token');
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err, 
    ErrorInterceptorHandler handler
  ) async {
    if (err.response?.statusCode == 401) {
      // Token might be expired, try to refresh
      try {
        final newToken = await _refreshToken();
        
        if (newToken != null) {
          // Retry the request with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          return handler.resolve(await Dio().fetch(err.requestOptions));
        }
      } catch (_) {
        // Refresh failed, logout user
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');
      
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:3000/graphql',
        data: {'refreshToken': refreshToken}
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        await _secureStorage.write(key: 'access_token', value: newAccessToken);
        await _secureStorage.write(key: 'refresh_token', value: newRefreshToken);

        return newAccessToken;
      }
    } catch (e) {
      // Logout user if refresh fails
      await _secureStorage.deleteAll();
    }
    return null;
  }
}