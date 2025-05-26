import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lyriverse/track/domain/model/track_image.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  final String name;
  final String playCount;
  final String listeners;
  final String artist;
  final List<TrackImage> images;

  const Track({
    required this.name,
    required this.playCount,
    required this.listeners,
    required this.artist,
    required this.images,
  });
}
