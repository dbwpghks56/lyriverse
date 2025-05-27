import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';
import 'package:lyriverse/track/data/mapper/track_mapper.dart';
import 'package:lyriverse/track/domain/model/track.dart';
import 'package:lyriverse/track/domain/repository/track_repository.dart';

class TrackRepositoryImpl implements TrackRepository {
  final TrackDataSource _dataSource;

  const TrackRepositoryImpl({required TrackDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<PaginatedResponse<Track>> findTracksByArtistAndName({
    required String track,
    String? artist,
    required PaginationRequest pagination,
  }) async {
    final PaginatedResponse<TrackDto> dtos = await _dataSource
        .findTracksByArtistAndName(
          track: track,
          artist: artist,
          pagination: pagination,
        );

    return PaginatedResponse(
      items: dtos.items.map((item) => item.toModel()).toList(),
      pagination: dtos.pagination,
    );
  }
}
