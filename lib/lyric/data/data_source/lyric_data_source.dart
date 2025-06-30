import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';

abstract interface class LyricDataSource {
  Future<LyricDto> findLyricByTrackAndArtist({
    required String track,
    required String artist,
  });
}
