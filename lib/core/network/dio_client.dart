import 'package:dio/dio.dart';
import 'package:giripet_mobile/core/constants/shared_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://46.31.77.59/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: 'application/json',
  ));

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Auth servislerine token gönderme!
        final isAuth = options.path.contains('/auth');

        if (!isAuth) {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(SharedPreferenceKeys.token);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }

        return handler.next(options);
      },
      onError: (e, handler) {
        // TODO: Hataları logla veya handle et
        return handler.next(e);
      },
    ));
  }

  Dio get client => _dio;
}
