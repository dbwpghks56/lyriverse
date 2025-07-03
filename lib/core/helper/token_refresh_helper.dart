import 'package:lyriverse/core/local/data_source/local_client.dart';
import 'package:lyriverse/spotify_auth/domain/use_case/spotify_auth_use_case.dart';

class TokenRefreshHelper {
  final LocalClient _localClient;
  final SpotifyAuthUseCase _spotifyAuthUseCase;

  const TokenRefreshHelper({
    required LocalClient localClient,
    required SpotifyAuthUseCase spotifyAuthUseCase,
  }) : _localClient = localClient,
       _spotifyAuthUseCase = spotifyAuthUseCase;

  Future<String?> getValidSpotifyToken() async {
    try {
      final accessToken = await _localClient.getString('accessToken');
      final expiresDate = await _localClient.getString('expiresDate');

      if (_isTokenExpired(expiresDate)) {
        await _spotifyAuthUseCase.execute();
        return await _localClient.getString('accessToken');
      }

      return accessToken;
    } catch (e) {
      try {
        await _spotifyAuthUseCase.execute();
        return await _localClient.getString('accessToken');
      } catch (e) {
        print('Failed to refresh Spotify token: $e');
        return null;
      }
    }
  }

  bool _isTokenExpired(String expiresDateString) {
    try {
      final expiresDate = DateTime.parse(expiresDateString);
      return DateTime.now().isAfter(expiresDate);
    } catch (e) {
      return true;
    }
  }
}
