import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}

class NetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(DioException error) {
    String errorMessage = 'Unknown error occurred';
    int? statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.badResponse:
        statusCode = error.response?.statusCode;
        errorMessage = _parseErrorResponse(error.response);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Network error';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Invalid certificate';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Connection error';
        break;
    }

    throw NetworkException(errorMessage, statusCode: statusCode);
  }

  String _parseErrorResponse(Response? response) {
    if (response?.data != null) {
      if (response!.data is Map && response.data['message'] != null) {
        return response.data['message'];
      }
      return response.data.toString();
    }
    return 'Unknown server error';
  }
}