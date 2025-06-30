import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_image.freezed.dart';

@freezed
class TrackImage with _$TrackImage {
  @override
  final String url;
  @override
  final int width;
  final int height;

  const TrackImage({
    required this.url,
    required this.width,
    required this.height,
  });
}
