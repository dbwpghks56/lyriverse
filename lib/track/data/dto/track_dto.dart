import 'package:json_annotation/json_annotation.dart';
import 'package:lyriverse/track/data/dto/track_image_dto.dart';

part 'track_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TrackDto {
  final String? name;
  @JsonKey(name: 'playcount')
  final String? playCount;
  final String? listeners;
  final String? artist;
  @JsonKey(name: 'image')
  final List<TrackImageDto>? images;

  const TrackDto({
    required this.name,
    required this.playCount,
    required this.listeners,
    required this.artist,
    required this.images,
  });

  factory TrackDto.fromJson(Map<String, dynamic> json) =>
      _$TrackDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TrackDtoToJson(this);
}
