import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lyriverse/core/data_source/dio/dio_data_source.dart';
import 'package:lyriverse/core/data_source/dio/dio_data_source_impl.dart';
import 'package:lyriverse/core/helper/network_helper.dart';
import 'package:lyriverse/track/data/data_source/remote_track_data_source_impl.dart';
import 'package:lyriverse/track/domain/data_source/track_data_source.dart';

final getIt = GetIt.instance;

void di() {
  getIt.registerSingleton<String>(
    'https://ws.audioscrobbler.com/2.0/',
    instanceName: 'lastFmUrl',
  );
  getIt.registerLazySingleton<Dio>(() => NetworkHelper.dio);
  getIt.registerLazySingleton<DioDataSource>(
    () => DioDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<TrackDataSource>(
    () => RemoteTrackDataSourceImpl(
      remoteDataSource: getIt<DioDataSource>(),
      remoteUrl: getIt<String>(instanceName: 'lastFmUrl'),
    ),
  );
}
