import 'package:dio/dio.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/models/http_exception.dart';
import 'package:lyriverse/core/network/models/http_response.dart';
import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';

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

  @override
  Future<HttpResponse<PaginatedResponse<T>>> getPaginated<T>(
    String path, {
    required PaginationRequest pagination,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Duration? timeout,
    required T Function(Map<String, dynamic>) itemParser,
    required PaginatedResponse<T> Function(Map<String, dynamic>, List<T>)
    responseParser,
  }) async {
    // Pagination 파라미터를 쿼리에 추가
    final combinedQueryParameters = {
      ...?queryParameters,
      ...pagination.toJson(),
    };

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: combinedQueryParameters,
        options: _buildOptions(headers, timeout),
      );

      // 개별 아이템들 파싱
      final items = <T>[];
      final responseData = response.data!;

      // API 응답 구조에 따라 아이템 리스트 추출 (예시)
      final itemsData = _extractItemsFromResponse(responseData);

      for (final itemData in itemsData) {
        try {
          if (itemData is Map<String, dynamic>) {
            items.add(itemParser(itemData));
          }
        } catch (e) {
          // 개별 아이템 파싱 실패 시 스킵
          continue;
        }
      }

      // PaginatedResponse 생성
      final paginatedResponse = responseParser(responseData, items);

      return HttpResponse<PaginatedResponse<T>>(
        data: paginatedResponse,
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

  List<dynamic> _extractItemsFromResponse(Map<String, dynamic> responseData) {
    if (responseData.containsKey('data') && responseData['data'] is List) {
      return responseData['data'] as List<dynamic>;
    }

    // LastFM API 구조: { "results": { "trackmatches": { "track": [...] } } }
    if (responseData.containsKey('results')) {
      final results = responseData['results'] as Map<String, dynamic>?;
      if (results?.containsKey('trackmatches') == true) {
        final trackMatches = results!['trackmatches'] as Map<String, dynamic>?;
        final tracks = trackMatches?['track'];
        if (tracks is List) {
          return tracks;
        } else if (tracks != null) {
          return [tracks]; // 단일 아이템을 리스트로 변환
        }
      }
    }

    return [];
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
