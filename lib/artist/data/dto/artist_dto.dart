import 'package:json_annotation/json_annotation.dart';

part 'artist_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistDto {
  final String? id;
  final String? href;
  final String? name;
  final String? type;

  const ArtistDto({
    required this.id,
    required this.href,
    required this.name,
    required this.type,
  });

  factory ArtistDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDtoToJson(this);
}
