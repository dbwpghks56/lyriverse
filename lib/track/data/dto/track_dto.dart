import 'package:json_annotation/json_annotation.dart';
import 'package:lyriverse/artist/data/dto/artist_dto.dart';
import 'package:lyriverse/track/data/dto/track_image_dto.dart';

part 'track_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TrackDto {
  final String? id;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final List<ArtistDto>? artists;
  @override
  final List<TrackImageDto>? images;

  const TrackDto({
    required this.id,
    required this.name,
    required this.type,
    required this.artists,
    required this.images,
  });

  factory TrackDto.fromJson(Map<String, dynamic> json) =>
      _$TrackDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TrackDtoToJson(this);
}
