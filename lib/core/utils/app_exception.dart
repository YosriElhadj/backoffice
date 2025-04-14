class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() {
    return 'AppException: $message (Code: ${code ?? "N/A"})';
  }
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, code: 'NETWORK_ERROR');
}

class AuthenticationException extends AppException {
  AuthenticationException(String message) 
    : super(message, code: 'AUTH_ERROR');
}