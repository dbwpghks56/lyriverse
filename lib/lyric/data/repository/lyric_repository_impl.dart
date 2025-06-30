import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';
import 'package:lyriverse/lyric/data/mapper/lyric_mapper.dart';
import 'package:lyriverse/lyric/domain/model/lyric.dart';
import 'package:lyriverse/lyric/domain/repository/lyric_repository.dart';

class LyricRepositoryImpl implements LyricRepository {
  final LyricDataSource _dataSource;

  const LyricRepositoryImpl({required LyricDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Lyric> findLyricByTrackAndArtist({
    required String track,
    required String artist,
  }) async {
    final LyricDto dto = await _dataSource.findLyricByTrackAndArtist(
      track: track,
      artist: artist,
    );

    return dto.toModel();
  }
}
