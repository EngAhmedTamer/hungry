import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handelError(DioError error){
    switch(error.type){
      case DioErrorType.connectionTimeout: return ApiError(message: 'Connection Timeout');
      case DioErrorType.badResponse: return ApiError(message: 'Bad Response');
      default: return ApiError(message: 'Unknown Error');
    }
  }
}