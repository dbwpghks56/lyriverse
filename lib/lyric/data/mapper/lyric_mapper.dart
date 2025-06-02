import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';
import 'package:lyriverse/lyric/domain/model/lyric.dart';

extension LyricDtoMapper on LyricDto {
  Lyric toModel() {
    return Lyric(
      id: id ?? -1,
      name: name ?? 'N/A',
      trackName: trackName ?? 'N/A',
      albumName: albumName ?? 'N/A',
      artistName: artistName ?? 'N/A',
      plainLyrics: plainLyrics ?? 'N/A',
    );
  }
}

extension LyricMapper on Lyric {
  LyricDto toDto() {
    return LyricDto(
      id: id,
      name: name,
      trackName: trackName,
      albumName: albumName,
      artistName: artistName,
      plainLyrics: plainLyrics,
    );
  }
}
