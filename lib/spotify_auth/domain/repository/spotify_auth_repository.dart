import 'package:lyriverse/spotify_auth/domain/model/spotify_token.dart';

abstract interface class SpotifyAuthRepository {
  Future<SpotifyToken> getAccessToken();
}
