import 'package:json_annotation/json_annotation.dart';

part 'artist_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistDto {
  final String? name;
  final String? url;

  const ArtistDto({required this.name, required this.url});

  factory ArtistDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDtoToJson(this);
}
