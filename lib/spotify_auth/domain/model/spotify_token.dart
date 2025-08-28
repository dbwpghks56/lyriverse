import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotify_token.freezed.dart';

@freezed
class SpotifyToken with _$SpotifyToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  const SpotifyToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });
}
