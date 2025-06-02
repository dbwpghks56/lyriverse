import 'package:flutter_test/flutter_test.dart';
import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';

import '../../fixtures/track_dto_fixtures.dart';
import 'mock_track_data_source_impl.dart';

void main() {
  group('Track Data Source Test : ', () {
    const String searchArtist = 'bigbang';
    const String searchTrack = 'last dance';

    late TrackDataSource dataSource;
    setUpAll(() {
      dataSource = MockTrackDataSourceImpl(
        dtos: trackDtoFixtures,
      );
    });
    test('노래 제목과 페이지네이션을 포함하여 검색되어야 한다.', () async {
      final PaginatedResponse<TrackDto> dtoPagination = await dataSource
          .findTracksByArtistAndName(
            track: searchTrack,
            pagination: const PaginationRequest(
              page: 0,
              limit: 5,
            ),
          );

      expect(dtoPagination.items.first, isA<TrackDto>());
      expect(dtoPagination.items.length, 5);
    });
    test('노래 제목과 페이지네이션, 가수까지 포함하여 검색되어야 한다.', () async {
      final PaginatedResponse<TrackDto> dtoPagination = await dataSource
          .findTracksByArtistAndName(
            track: searchTrack,
            artist: searchArtist,
            pagination: const PaginationRequest(
              page: 0,
              limit: 10,
            ),
          );

      expect(dtoPagination.items.first, isA<TrackDto>());
      expect(dtoPagination.items.length, 10);
    });
  });
}
