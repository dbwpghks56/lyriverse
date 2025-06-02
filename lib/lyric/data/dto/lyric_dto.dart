import 'package:json_annotation/json_annotation.dart';

part 'lyric_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LyricDto {
  final int? id;
  final String? name;
  final String? trackName;
  final String? artistName;
  final String? albumName;
  final String? plainLyrics;

  const LyricDto({
    required this.id,
    required this.name,
    required this.trackName,
    required this.artistName,
    required this.albumName,
    required this.plainLyrics,
  });

  factory LyricDto.fromJson(Map<String, dynamic> json) =>
      _$LyricDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LyricDtoToJson(this);
}
