import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_info.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';

class MockTrackDataSourceImpl implements TrackDataSource {
  final List<TrackDto> _dtos;

  const MockTrackDataSourceImpl({required List<TrackDto> dtos}) : _dtos = dtos;

  @override
  Future<PaginatedResponse<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
    required PaginationRequest pagination,
  }) async {
    List<TrackDto> filteredTracks =
        _dtos.where((dto) {
          bool trackMatches = dto.name!.toLowerCase().contains(
            track.toLowerCase(),
          );
          bool artistMatches =
              artist == null ||
              dto.artist!.toLowerCase().contains(artist.toLowerCase());
          return trackMatches && artistMatches;
        }).toList();

    int totalCount = filteredTracks.length;
    int offset = pagination.page;
    int limit = pagination.limit;
    final int totalPages = (totalCount / pagination.limit).ceil();

    int startIndex = offset;
    int endIndex = (startIndex + limit).clamp(0, totalCount);

    List<TrackDto> paginatedTracks =
        startIndex < totalCount
            ? filteredTracks.sublist(startIndex, endIndex)
            : [];

    return PaginatedResponse<TrackDto>(
      items: paginatedTracks,
      pagination: PaginationInfo(
        itemsPerPage: pagination.limit,
        totalItems: totalCount,
        totalPages: totalPages,
        currentPage: offset,
      ),
    );
  }
}
