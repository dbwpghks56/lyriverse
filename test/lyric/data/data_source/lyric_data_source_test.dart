import 'package:flutter_test/flutter_test.dart';
import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';

import '../../fixtures/lyric_dto_fixtures.dart';
import 'mock_lyric_data_source_impl.dart';

void main() {
  group('Lyric Data Source Test : ', () {
    const String searchArtist = 'bigbang';
    const String searchTrack = 'last dance';

    late LyricDataSource dataSource;
    setUpAll(() {
      dataSource = MockLyricDataSourceImpl(
        dtos: lyricDtoFixtures,
      );
    });
    test('노래 제목과 가수를 이용해서 가사가 검색되어야 한다.', () async {
      final LyricDto dto = await dataSource.findLyricByTrackAndArtist(
        track: searchTrack,
        artist: searchArtist,
      );

      expect(dto, isA<LyricDto>());
      expect(dto.trackName?.toLowerCase(), searchTrack);
      expect(dto.artistName?.toLowerCase(), searchArtist);
    });
  });
}
