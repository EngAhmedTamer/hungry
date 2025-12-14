import 'package:dio/dio.dart';
import 'package:hungry/core/network/dio_client.dart';

import 'api_exceptions.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }
  Future<dynamic> delete(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }







}
