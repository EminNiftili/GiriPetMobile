import 'dart:io';

import 'package:dio/dio.dart';
import 'package:giripet_mobile/core/network/dio_client.dart';
import 'package:giripet_mobile/data/models/user.dart';

class UserDataSource {
  final Dio _dio = DioClient().client;

  Future<User?> me() async {
    var response = await _dio.get('/users/me');
    if (response.statusCode != HttpStatus.OK) {
      return null;
    }
    return User.fromJson(response.data);
  }
}
