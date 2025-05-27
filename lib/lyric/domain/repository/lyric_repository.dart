import 'package:lyriverse/lyric/domain/model/lyric.dart';

abstract interface class LyricRepository {
  Future<Lyric> findLyricByTrackAndArtist({
    required String track,
    required String artist,
  });
}
