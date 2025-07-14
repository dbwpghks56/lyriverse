// lib/core/helper/network_helper.dart
import 'package:dio/dio.dart';
import 'package:lyriverse/core/helper/token_refresh_helper.dart';
import 'package:lyriverse/core/local/data_source/local_client.dart';

abstract class NetworkHelper {
  static Dio createDio({
    LocalClient? localClient,
    TokenRefreshHelper? tokenRefreshHelper,
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_isSpotifyUrl(options.uri.toString())) {
            if (tokenRefreshHelper != null) {
              final accessToken =
                  await tokenRefreshHelper.getValidSpotifyToken();
              if (accessToken != null) {
                options.headers['Authorization'] = accessToken;
              }
            } else if (localClient != null) {
              try {
                final accessToken = await localClient.getString('accessToken');
                final expiresDate = await localClient.getString('expiresDate');

                if (!_isTokenExpired(expiresDate)) {
                  options.headers['Authorization'] = accessToken;
                } else {
                  print(
                    'Spotify token expired and no refresh helper available',
                  );
                }
              } catch (e) {
                print('Failed to get Spotify token: $e');
              }
            }
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  static bool _isSpotifyUrl(String url) {
    return url.contains('api.spotify.com');
  }

  static bool _isTokenExpired(String expiresDateString) {
    try {
      final expiresDate = DateTime.parse(expiresDateString);
      return DateTime.now().isAfter(expiresDate);
    } catch (e) {
      return true;
    }
  }

  @Deprecated('Use createDio() instead')
  static final Dio dio = createDio();
}
