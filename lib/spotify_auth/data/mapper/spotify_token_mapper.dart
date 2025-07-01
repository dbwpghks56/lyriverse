import 'package:lyriverse/spotify_auth/data/dto/spotify_token_dto.dart';
import 'package:lyriverse/spotify_auth/domain/model/spotify_token.dart';

extension SpotifyTokenMapper on SpotifyTokenDto {
  SpotifyToken toModel() {
    return SpotifyToken(
      accessToken: accessToken ?? 'N/A',
      tokenType: tokenType ?? 'N/A',
      expiresIn: expiresIn ?? 0,
    );
  }
}
