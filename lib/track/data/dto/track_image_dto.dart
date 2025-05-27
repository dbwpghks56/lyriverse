import 'package:json_annotation/json_annotation.dart';

part 'track_image_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TrackImageDto {
  @JsonKey(name: '#text')
  final String? imageUrl;
  final String? size;

  const TrackImageDto({required this.imageUrl, required this.size});

  factory TrackImageDto.fromJson(Map<String, dynamic> json) =>
      _$TrackImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TrackImageDtoToJson(this);
}
