import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_image.freezed.dart';

@freezed
class TrackImage with _$TrackImage {
  final String imageUrl;
  final String size;

  const TrackImage({
    required this.imageUrl,
    required this.size,
  });
}
