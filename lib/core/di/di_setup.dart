import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lyriverse/core/helper/network_helper.dart';
import 'package:lyriverse/core/network/data_source/impl/dio_http_client.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/lyric/data/data_source/impl/remote_lyric_data_source.dart';
import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/repository/lyric_repository_impl.dart';
import 'package:lyriverse/lyric/domain/repository/lyric_repository.dart';
import 'package:lyriverse/track/data/data_source/impl/remote_track_data_source_impl.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/repository/track_repository_impl.dart';
import 'package:lyriverse/track/domain/repository/track_repository.dart';

final getIt = GetIt.instance;

void di() {
  getIt.registerSingleton<String>(
    'https://ws.audioscrobbler.com/2.0/',
    instanceName: 'lastFmUrl',
  );
  getIt.registerSingleton<String>(
    'https://lrclib.net/api/get',
    instanceName: 'lyricUrl',
  );
  getIt.registerLazySingleton<Dio>(() => NetworkHelper.dio);
  getIt.registerLazySingleton<HttpClient>(
    () => DioHttpClient(dio: getIt<Dio>()),
  );

  // Track DI
  getIt.registerLazySingleton<TrackDataSource>(
    () => RemoteTrackDataSourceImpl(
      httpClient: getIt<HttpClient>(),
      remoteUrl: getIt<String>(instanceName: 'lastFmUrl'),
    ),
  );
  getIt.registerLazySingleton<TrackRepository>(
    () => TrackRepositoryImpl(dataSource: getIt<TrackDataSource>()),
  );

  // Lyric DI
  getIt.registerLazySingleton<LyricDataSource>(
    () => RemoteLyricDataSource(
      httpClient: getIt<HttpClient>(),
      remoteUrl: getIt<String>(instanceName: 'lyricUrl'),
    ),
  );
  getIt.registerLazySingleton<LyricRepository>(
    () => LyricRepositoryImpl(dataSource: getIt<LyricDataSource>()),
  );
}
