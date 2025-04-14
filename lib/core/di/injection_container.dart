import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/token_interceptor.dart';
import '../network/network_service.dart';

class InjectionContainer {
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Dio createDioClient() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000/graphql',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));

    dio.interceptors.addAll([
      TokenInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);

    return dio;
  }

  static NetworkService createNetworkService() {
    return NetworkService(createDioClient());
  }
}