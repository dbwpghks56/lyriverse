import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lyriverse/core/helper/network_helper.dart';

final getIt = GetIt.instance;

void di() {
  getIt.registerLazySingleton<Dio>(() => NetworkHelper.dio);
}
