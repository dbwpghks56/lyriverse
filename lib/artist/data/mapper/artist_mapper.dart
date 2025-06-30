import 'package:lyriverse/artist/data/dto/artist_dto.dart';
import 'package:lyriverse/artist/domain/model/artist.dart';

extension ArtistDtoMapper on ArtistDto {
  Artist toModel() {
    return Artist(
      id: id ?? 'N/A',
      name: name ?? 'N/A',
      href: href ?? 'N/A',
      type: type ?? 'N/A',
    );
  }
}

extension ArtistMapper on Artist {
  ArtistDto toDto() {
    return ArtistDto(
      id: id,
      name: name,
      href: href,
      type: type,
    );
  }
}
