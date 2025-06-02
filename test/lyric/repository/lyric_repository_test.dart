import 'package:flutter_test/flutter_test.dart';
import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';
import 'package:lyriverse/lyric/data/repository/lyric_repository_impl.dart';
import 'package:lyriverse/lyric/domain/model/lyric.dart';
import 'package:lyriverse/lyric/domain/repository/lyric_repository.dart';

import '../data/data_source/mock_lyric_data_source_impl.dart';
import '../fixtures/lyric_dto_fixtures.dart';

void main() {
  group('Lyric Data Source Test : ', () {
    const String searchArtist = 'bigbang';
    const String searchTrack = 'last dance';

    late LyricDataSource dataSource;
    late LyricRepository repository;
    setUpAll(() {
      dataSource = MockLyricDataSourceImpl(
        dtos: lyricDtoFixtures,
      );
      repository = LyricRepositoryImpl(dataSource: dataSource);
    });
    test('노래 제목과 가수를 이용해서 가사가 검색되어야 한다.', () async {
      final Lyric data = await repository.findLyricByTrackAndArtist(
        track: searchTrack,
        artist: searchArtist,
      );

      expect(data, isA<Lyric>());
      expect(data.trackName.toLowerCase(), searchTrack);
      expect(data.artistName.toLowerCase(), searchArtist);
    });
  });
}
