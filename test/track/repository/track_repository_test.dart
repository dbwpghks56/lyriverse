import 'package:flutter_test/flutter_test.dart';
import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/repository/track_repository_impl.dart';
import 'package:lyriverse/track/domain/model/track.dart';
import 'package:lyriverse/track/domain/repository/track_repository.dart';

import '../data/data_source/mock_track_data_source_impl.dart';
import '../fixtures/track_dto_fixtures.dart';

void main() {
  group('Track Repository Test : ', () {
    const String searchArtist = 'bigbang';
    const String searchTrack = 'last dance';

    late TrackDataSource dataSource;
    late TrackRepository trackRepository;

    setUpAll(() {
      dataSource = MockTrackDataSourceImpl(
        dtos: trackDtoFixtures,
      );
      trackRepository = TrackRepositoryImpl(dataSource: dataSource);
    });
    test('노래 제목과 페이지네이션을 포함하여 검색되어야 한다.', () async {
      final PaginatedResponse<Track> trackPagination = await trackRepository
          .findTracksByArtistAndName(
            track: searchTrack,
            pagination: const PaginationRequest(
              page: 0,
              limit: 5,
            ),
          );

      expect(trackPagination.items.first, isA<Track>());
      expect(trackPagination.items.length, 5);
    });
    test('노래 제목과 페이지네이션, 가수까지 포함하여 검색되어야 한다.', () async {
      final PaginatedResponse<Track> trackPagination = await trackRepository
          .findTracksByArtistAndName(
            track: searchTrack,
            artist: searchArtist,
            pagination: const PaginationRequest(
              page: 0,
              limit: 10,
            ),
          );

      expect(trackPagination.items.first, isA<Track>());
      expect(trackPagination.items.length, 10);
    });
  });
}
