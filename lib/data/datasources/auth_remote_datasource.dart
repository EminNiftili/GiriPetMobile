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
}
