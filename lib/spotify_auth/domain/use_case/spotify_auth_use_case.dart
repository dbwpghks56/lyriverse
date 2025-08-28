import 'package:lyriverse/core/local/data_source/local_client.dart';
import 'package:lyriverse/spotify_auth/domain/model/spotify_token.dart';
import 'package:lyriverse/spotify_auth/domain/repository/spotify_auth_repository.dart';

class SpotifyAuthUseCase {
  final SpotifyAuthRepository _repository;
  final LocalClient _localClient;

  const SpotifyAuthUseCase({
    required SpotifyAuthRepository repository,
    required LocalClient localClient,
  }) : _repository = repository,
       _localClient = localClient;

  Future<void> execute() async {
    final SpotifyToken token = await _repository.getAccessToken();
    final DateTime currentTime = DateTime.now();

    await _localClient.setString(
      'accessToken',
      '${token.tokenType} ${token.accessToken}',
    );
    await _localClient.setString(
      'expiresDate',
      DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        currentTime.hour,
        currentTime.minute,
        currentTime.second + token.expiresIn,
      ).toIso8601String(),
    );
  }
}
