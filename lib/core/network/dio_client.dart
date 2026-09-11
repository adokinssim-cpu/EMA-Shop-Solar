import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required String baseUrl, required String apiKey})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': apiKey,
          },
        ),
      );
}
