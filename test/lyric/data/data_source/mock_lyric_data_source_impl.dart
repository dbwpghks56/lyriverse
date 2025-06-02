import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';

class MockLyricDataSourceImpl implements LyricDataSource {
  final List<LyricDto> dtos;

  const MockLyricDataSourceImpl({required this.dtos});

  @override
  Future<LyricDto> findLyricByTrackAndArtist({
    required String track,
    required String artist,
  }) async {
    final LyricDto dto = dtos.firstWhere(
      (dto) =>
          dto.trackName?.toLowerCase() == track.toLowerCase() &&
          dto.artistName?.toLowerCase() == artist.toLowerCase(),
    );

    return dto;
  }
}
