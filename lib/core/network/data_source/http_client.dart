import 'package:lyriverse/core/network/models/http_response.dart';

abstract interface class HttpClient {
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  });

  Future<HttpResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  });

  Future<HttpResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  });

  Future<HttpResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  });

  Future<HttpResponse<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  });
}
