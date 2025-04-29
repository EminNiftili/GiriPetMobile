import 'dart:io';

import 'package:dio/dio.dart';
import 'package:giripet_mobile/core/network/dio_client.dart';
import 'package:giripet_mobile/data/models/user.dart';

class UserDataSource {
  final Dio _dio = DioClient().client;

  Future<User?> me() async {
    try {
      var response = await _dio.get('/users/me');
      if (response.statusCode != HttpStatus.OK) {
        return null;
      }
      return User.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> update(
      {required int id,
      required String fullName,
      required String phone}) async {
    try {
      var response = await _dio.put('/users', data: {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phone,
      });
      return response.statusCode == HttpStatus.NO_CONTENT;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAccount({required int id}) async {
    try {
      var response = await _dio.delete('/users?id=${id}');
      return response.statusCode == HttpStatus.NO_CONTENT;
    } catch (e) {
      return false;
    }
  }
}
