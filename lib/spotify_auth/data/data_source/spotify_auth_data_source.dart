import 'package:lyriverse/spotify_auth/data/dto/spotify_token_dto.dart';

abstract interface class SpotifyAuthDataSource {
  Future<SpotifyTokenDto> getAccessToken();
}
