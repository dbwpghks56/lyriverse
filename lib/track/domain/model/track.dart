import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lyriverse/artist/domain/model/artist.dart';
import 'package:lyriverse/track/domain/model/track_image.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final List<Artist> artists;
  @override
  final List<TrackImage> images;

  const Track({
    required this.id,
    required this.name,
    required this.type,
    required this.artists,
    required this.images,
  });
}
