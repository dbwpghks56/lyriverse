import 'package:json_annotation/json_annotation.dart';

part 'track_image_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TrackImageDto {
  final String? url;
  final int? width;
  final int? height;

  const TrackImageDto({
    required this.url,
    required this.width,
    required this.height,
  });

  factory TrackImageDto.fromJson(Map<String, dynamic> json) =>
      _$TrackImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TrackImageDtoToJson(this);
}
