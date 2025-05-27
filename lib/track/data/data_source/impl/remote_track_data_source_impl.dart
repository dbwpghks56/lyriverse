import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/pagination/paginated_response.dart';
import 'package:lyriverse/core/network/pagination/pagination_info.dart';
import 'package:lyriverse/core/network/pagination/pagination_request.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';
import 'package:lyriverse/track/data/data_source/track_data_source.dart';

class RemoteTrackDataSourceImpl implements TrackDataSource {
  final HttpClient _httpClient;
  final String remoteUrl;

  const RemoteTrackDataSourceImpl({
    required HttpClient httpClient,
    required this.remoteUrl,
  }) : _httpClient = httpClient;

  @override
  Future<PaginatedResponse<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
    required PaginationRequest pagination,
  }) async {
    try {
      final response = await _httpClient.getPaginated<TrackDto>(
        remoteUrl,
        pagination: pagination,
        queryParameters: {
          'method': 'track.search',
          'track': track,
          'format': 'json',
          if (artist != null) 'artist': artist,
        },
        itemParser: (itemData) => TrackDto.fromJson(itemData),
        responseParser: (responseData, tracks) {
          return _buildPaginatedResponse(responseData, tracks, pagination);
        },
      );

      if (!response.isSuccessful || response.data == null) {
        return PaginatedResponse<TrackDto>(
          items: [],
          pagination: PaginationInfo(
            currentPage: pagination.page,
            totalPages: 0,
            totalItems: 0,
            itemsPerPage: pagination.limit,
          ),
        );
      }

      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  PaginatedResponse<TrackDto> _buildPaginatedResponse(
    Map<String, dynamic> responseData,
    List<TrackDto> tracks,
    PaginationRequest request,
  ) {
    final int totalItems = int.parse(
      responseData['results']['opensearch:totalResults'],
    );
    final int totalPages = (totalItems / request.limit).ceil();

    final paginationInfo = PaginationInfo(
      currentPage: request.page,
      totalPages: totalPages,
      totalItems: totalItems,
      itemsPerPage: request.limit,
    );

    return PaginatedResponse<TrackDto>(
      items: tracks,
      pagination: paginationInfo,
    );
  }
}
