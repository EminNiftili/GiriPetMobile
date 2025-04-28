import 'dart:io';

import 'package:dio/dio.dart';
import 'package:giripet_mobile/core/network/dio_client.dart';

class AuthRemoteDataSource {
  final Dio _dio = DioClient().client;

  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    return _dio.post('/auth/register', data: {
      'FullName': name,
      'Email': email,
      'Password': password,
      'PhoneNumber': phone,
    });
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == HttpStatus.OK) {
        return response.data['token'] as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
