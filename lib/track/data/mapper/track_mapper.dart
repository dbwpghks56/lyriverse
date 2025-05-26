import 'package:lyriverse/track/data/dto/track_dto.dart';
import 'package:lyriverse/track/data/mapper/track_image_mapper.dart';
import 'package:lyriverse/track/domain/model/track.dart';

extension TrackDtoMapper on TrackDto {
  Track toModel() {
    return Track(
      name: name ?? 'N/A',
      playCount: playCount ?? '0',
      listeners: listeners ?? '0',
      images: images?.map((image) => image.toModel()).toList() ?? [],
      artist: artist ?? 'N/A',
    );
  }
}

extension TrackMapper on Track {
  TrackDto toDto() {
    return TrackDto(
      name: name,
      playCount: playCount,
      listeners: listeners,
      images: images.map((image) => image.toDto()).toList(),
      artist: artist,
    );
  }
}
