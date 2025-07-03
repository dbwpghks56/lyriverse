import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lyriverse/core/helper/network_helper.dart';
import 'package:lyriverse/core/helper/token_refresh_helper.dart';
import 'package:lyriverse/core/local/data_source/impl/pref_client.dart';
import 'package:lyriverse/core/local/data_source/local_client.dart';
import 'package:lyriverse/core/network/data_source/impl/dio_http_client.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/lyric/data/data_source/impl/remote_lyric_data_source.dart';
import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/repository/lyric_repository_impl.dart';
import 'package:lyriverse/lyric/domain/repository/lyric_repository.dart';
import 'package:lyriverse/spotify_auth/data/data_source/impl/spotify_auth_data_source_impl.dart';
import 'package:lyriverse/spotify_auth/data/data_source/spotify_auth_data_source.dart';
import 'package:lyriverse/spotify_auth/data/repository/spotify_auth_repository_impl.dart';
import 'package:lyriverse/spotify_auth/domain/repository/spotify_auth_repository.dart';
import 'package:lyriverse/spotify_auth/domain/use_case/spotify_auth_use_case.dart';
import 'package:lyriverse/track/data/data_source/impl/remote_track_data_source_impl.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/repository/track_repository_impl.dart';
import 'package:lyriverse/track/domain/repository/track_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> di() async {
  getIt.registerSingleton<String>(
    'https://ws.audioscrobbler.com/2.0/',
    instanceName: 'lastFmUrl',
  );
  getIt.registerSingleton<String>(
    'https://accounts.spotify.com/api/token',
    instanceName: 'spotifyAuth',
  );
  getIt.registerSingleton<String>(
    'https://lrclib.net/api/get',
    instanceName: 'lyricUrl',
  );

  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  // SharedPreferences 초기화 완료 대기
  await getIt.isReady<SharedPreferences>();

  // 2. LocalClient 등록
  getIt.registerLazySingleton<LocalClient>(
    () => PrefClient(sharedPreferences: getIt<SharedPreferences>()),
  );

  // 기본 Dio 인스턴스 (토큰 갱신 기능 없음)
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
    instanceName: 'basicDio',
  );

  getIt.registerLazySingleton<HttpClient>(
    () => DioHttpClient(dio: getIt<Dio>(instanceName: 'basicDio')),
    instanceName: 'basicHttpClient',
  );

  getIt.registerLazySingleton<SpotifyAuthDataSource>(
    () => SpotifyAuthDataSourceImpl(
      httpClient: getIt<HttpClient>(instanceName: 'basicHttpClient'),
      remoteUrl: getIt<String>(instanceName: 'spotifyAuth'),
    ),
  );

  getIt.registerLazySingleton<SpotifyAuthRepository>(
    () => SpotifyAuthRepositoryImpl(dataSource: getIt<SpotifyAuthDataSource>()),
  );

  getIt.registerLazySingleton<SpotifyAuthUseCase>(
    () => SpotifyAuthUseCase(
      localClient: getIt<LocalClient>(),
      repository: getIt<SpotifyAuthRepository>(),
    ),
  );

  // TokenRefreshHelper 등록 가능
  getIt.registerLazySingleton<TokenRefreshHelper>(
    () => TokenRefreshHelper(
      localClient: getIt<LocalClient>(),
      spotifyAuthUseCase: getIt<SpotifyAuthUseCase>(),
    ),
  );

  // 토큰 갱신 기능이 있는 메인 Dio 인스턴스
  getIt.registerLazySingleton<Dio>(
    () => NetworkHelper.createDio(
      localClient: getIt<LocalClient>(),
      tokenRefreshHelper: getIt<TokenRefreshHelper>(),
    ),
    instanceName: 'mainDio',
  );

  getIt.registerLazySingleton<HttpClient>(
    () => DioHttpClient(dio: getIt<Dio>(instanceName: 'mainDio')),
  );

  // Track DI (메인 HttpClient 사용)
  getIt.registerLazySingleton<TrackDataSource>(
    () => RemoteTrackDataSourceImpl(
      httpClient: getIt<HttpClient>(),
      remoteUrl: getIt<String>(instanceName: 'lastFmUrl'),
    ),
  );

  getIt.registerLazySingleton<TrackRepository>(
    () => TrackRepositoryImpl(dataSource: getIt<TrackDataSource>()),
  );

  // Lyric DI (메인 HttpClient 사용)
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
