import 'package:lyriverse/artist/data/dto/artist_dto.dart';
import 'package:lyriverse/artist/domain/model/artist.dart';

extension ArtistDtoMapper on ArtistDto {
  Artist toModel() {
    return Artist(name: name ?? 'N/A', url: url ?? 'N/A');
  }
}

extension ArtistMapper on Artist {
  ArtistDto toDto() {
    return ArtistDto(name: name, url: url);
  }
}
