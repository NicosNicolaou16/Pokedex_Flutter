import 'package:dio/dio.dart';

class ErrorHandling {
  static String getErrorMessage(
      DioException? dioException, String? errorMessage, int statusCode) {
    if (errorMessage != null) {
      return errorMessage;
    } else if (dioException != null && dioException.response != null) {
      return dioException.response?.data?["data"] ??
          dioException.message ??
          "Something went wrong";
    }
    return "Something went wrong";
  }
}
