import 'package:lyriverse/artist/data/mapper/artist_mapper.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';
import 'package:lyriverse/track/data/mapper/track_image_mapper.dart';
import 'package:lyriverse/track/domain/model/track.dart';

extension TrackDtoMapper on TrackDto {
  Track toModel() {
    return Track(
      id: id ?? 'N/A',
      name: name ?? 'N/A',
      type: type ?? 'N/A',
      images: images?.map((image) => image.toModel()).toList() ?? [],
      artists: artists?.map((artist) => artist.toModel()).toList() ?? [],
    );
  }
}

extension TrackMapper on Track {
  TrackDto toDto() {
    return TrackDto(
      id: id,
      name: name,
      type: type,
      images: images.map((image) => image.toDto()).toList(),
      artists: artists.map((artist) => artist.toDto()).toList(),
    );
  }
}
