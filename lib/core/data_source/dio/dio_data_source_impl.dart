import 'package:dio/dio.dart';
import 'package:lyriverse/core/data_source/dio/dio_data_source.dart';

class DioDataSourceImpl implements DioDataSource {
  final Dio dio;

  const DioDataSourceImpl({required this.dio});

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int p1, int p2)? onReceiveProgress,
  }) async {
    return dio.get<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
