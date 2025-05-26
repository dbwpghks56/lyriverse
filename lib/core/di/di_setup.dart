import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lyriverse/core/helper/network_helper.dart';
import 'package:lyriverse/core/network/data_source/dio_http_client.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/track/data/data_source/remote_track_data_source_impl.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';

final getIt = GetIt.instance;

void di() {
  getIt.registerSingleton<String>(
    'https://ws.audioscrobbler.com/2.0/',
    instanceName: 'lastFmUrl',
  );
  getIt.registerLazySingleton<Dio>(() => NetworkHelper.dio);
  getIt.registerLazySingleton<HttpClient>(
    () => DioHttpClient(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<TrackDataSource>(
    () => RemoteTrackDataSourceImpl(
      httpClient: getIt<HttpClient>(),
      remoteUrl: getIt<String>(instanceName: 'lastFmUrl'),
    ),
  );
}
