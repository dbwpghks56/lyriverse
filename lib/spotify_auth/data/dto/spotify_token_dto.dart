import 'package:json_annotation/json_annotation.dart';

part 'spotify_token_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SpotifyTokenDto {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  const SpotifyTokenDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory SpotifyTokenDto.fromJson(Map<String, dynamic> json) =>
      _$SpotifyTokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpotifyTokenDtoToJson(this);
}
