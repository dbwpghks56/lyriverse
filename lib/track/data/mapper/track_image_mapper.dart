import 'package:lyriverse/track/data/dto/track_image_dto.dart';
import 'package:lyriverse/track/domain/model/track_image.dart';

extension TrackImageDtoMapper on TrackImageDto {
  TrackImage toModel() {
    return TrackImage(
      url: url ?? 'N/A',
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}

extension TrackImageMapper on TrackImage {
  TrackImageDto toDto() {
    return TrackImageDto(
      url: url,
      width: width,
      height: height,
    );
  }
}
