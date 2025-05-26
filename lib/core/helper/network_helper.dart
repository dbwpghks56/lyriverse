import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class NetworkHelper {
  static final Dio dio =
      Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              return handler.next(options);
            },
            onResponse: (response, handler) {
              return handler.next(response);
            },
            onError: (DioException e, handler) {
              return handler.next(e);
            },
          ),
        )
        ..options.queryParameters['api_key'] = dotenv.env['LASTFM_KEY'];
}
