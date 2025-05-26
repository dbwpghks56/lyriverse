import 'package:dio/dio.dart';

abstract class NetworkHelper {
  static final Dio dio =
      Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {},
            onResponse: (response, handler) {},
            onError: (DioException e, handler) {},
          ),
        );
}
