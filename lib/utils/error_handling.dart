import 'package:dio/dio.dart';

class ErrorHandling {
  static String getErrorMessage(
      DioException? dioException, String? errorMessage, int statusCode) {
    if (errorMessage != null) return errorMessage;
    if (dioException == null) return "Something went wrong";
    switch (dioException.type) {
      case DioExceptionType.connectionError:
        return "No internet connection";
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return "The server took too long to respond";
      default:
        break;
    }
    final data = dioException.response?.data;
    if (data is Map && data["data"] is String) return data["data"] as String;
    if (data is String && data.isNotEmpty) return data;
    return dioException.message ?? "Something went wrong";
  }
}
