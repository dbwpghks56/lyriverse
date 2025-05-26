import 'package:dio/dio.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/models/http_exception.dart';
import 'package:lyriverse/core/network/models/http_response.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  const DioHttpClient({required Dio dio}) : _dio = dio;

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    return _executeRequest<T>(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: _buildOptions(headers, timeout),
      ),
    );
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    return _executeRequest<T>(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(headers, timeout),
      ),
    );
  }

  @override
  Future<HttpResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    return _executeRequest<T>(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(headers, timeout),
      ),
    );
  }

  @override
  Future<HttpResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    return _executeRequest<T>(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(headers, timeout),
      ),
    );
  }

  @override
  Future<HttpResponse<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    return _executeRequest<T>(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(headers, timeout),
      ),
    );
  }

  Options? _buildOptions(
    Map<String, String>? headers,
    Duration? timeout,
  ) {
    if (headers == null && timeout == null) return null;

    return Options(
      headers: headers,
      sendTimeout: timeout,
      receiveTimeout: timeout,
    );
  }

  Future<HttpResponse<T>> _executeRequest<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      final response = await request();
      return HttpResponse<T>(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage,
        headers: response.headers.map.map(
          (key, value) => MapEntry(key, value.join(', ')),
        ),
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  HttpException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          'Request timeout: ${e.message}',
          e.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return ServerException(
          'Server error: ${e.message}',
          e.response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          'Connection error: ${e.message}',
          e.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          'Request cancelled: ${e.message}',
          e.response?.statusCode,
        );
      default:
        return UnknownException(
          'Unknown error: ${e.message}',
          e.response?.statusCode,
        );
    }
  }
}
