import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/domain/model/track.dart';

abstract interface class TrackRepository {
  Future<PaginatedResponse<Track>> findTracksByArtistAndName({
    required String track,
    String? artist,
    required PaginationRequest pagination,
  });
}
