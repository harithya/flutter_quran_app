import 'package:dio/dio.dart';

class Api {
  static final Api _instance = Api._internal();
  factory Api() => _instance;

  late Dio dio;

  Api._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://equran.id/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print("REQUEST[${options.method}] => PATH: ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // print("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }
}
