import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/network_service.dart';

class ErrorHandlerNotifier extends StateNotifier<String?> {
  ErrorHandlerNotifier() : super(null);

  void handleError(dynamic error) {
    if (error is NetworkException) {
      state = error.message;
    } else {
      state = 'An unexpected error occurred';
    }
  }

  void clearError() {
    state = null;
  }
}

final errorHandlerProvider = StateNotifierProvider<ErrorHandlerNotifier, String?>(
  (ref) => ErrorHandlerNotifier(),
);