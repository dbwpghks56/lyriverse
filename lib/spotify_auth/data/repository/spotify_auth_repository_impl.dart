import 'package:lyriverse/spotify_auth/data/data_source/spotify_auth_data_source.dart';
import 'package:lyriverse/spotify_auth/data/mapper/spotify_token_mapper.dart';
import 'package:lyriverse/spotify_auth/domain/model/spotify_token.dart';
import 'package:lyriverse/spotify_auth/domain/repository/spotify_auth_repository.dart';

class SpotifyAuthRepositoryImpl implements SpotifyAuthRepository {
  final SpotifyAuthDataSource _dataSource;

  const SpotifyAuthRepositoryImpl({required SpotifyAuthDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<SpotifyToken> getAccessToken() async {
    return (await _dataSource.getAccessToken()).toModel();
  }
}
