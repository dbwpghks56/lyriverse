import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';

abstract interface class TrackDataSource {
  Future<PaginatedResponse<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
    required PaginationRequest pagination,
  });
}
