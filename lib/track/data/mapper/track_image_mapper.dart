import 'package:lyriverse/track/data/dto/track_image_dto.dart';
import 'package:lyriverse/track/domain/model/track_image.dart';

extension TrackImageDtoMapper on TrackImageDto {
  TrackImage toModel() {
    return TrackImage(
      imageUrl: imageUrl ?? 'N/A',
      size: size ?? '0',
    );
  }
}

extension TrackImageMapper on TrackImage {
  TrackImageDto toDto() {
    return TrackImageDto(
      imageUrl: imageUrl,
      size: size,
    );
  }
}
