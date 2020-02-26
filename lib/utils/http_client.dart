import 'package:dio/dio.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient._internal();
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://old.reddit.com/r/",
      queryParameters: {"limit": 100},
    ),
  );

  factory HttpClient() {
    return _singleton;
  }

  HttpClient._internal();
}
