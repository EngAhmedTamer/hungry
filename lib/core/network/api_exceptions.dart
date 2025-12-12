import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handelError(DioError error){
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
   if (data is Map<String,dynamic> && data['message']!=null){
     return ApiError(message: data['message'],statusCode: statusCode);
   }
   print(statusCode);
   print(data);

   if(statusCode == 302){
    throw ApiError(message: 'the email is already in use');
   }

    switch(error.type){
      case DioErrorType.connectionTimeout: return ApiError(message: 'Connection Timeout');
      case DioErrorType.sendTimeout: return ApiError(message: 'Send Timeout');
      case DioErrorType.receiveTimeout: return ApiError(message: 'Receive Timeout');
      case DioErrorType.cancel: return ApiError(message: 'Request Cancelled');
      case DioErrorType.unknown: return ApiError(message: 'Unknown Error');
      case DioErrorType.badResponse: return ApiError(message: 'Try again ');
      case DioErrorType.badCertificate: return ApiError(message: 'Bad Certificate');
      case DioErrorType.connectionError: return ApiError(message: 'Connection Error');

      default: return ApiError(message: 'Unknown Error');
    }
  }
}