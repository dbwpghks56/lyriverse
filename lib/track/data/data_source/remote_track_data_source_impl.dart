import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/models/http_exception.dart';
import 'package:lyriverse/core/network/models/http_response.dart';
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
  Future<List<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
  }) async {
    try {
      final HttpResponse response = await _httpClient.get<Map<String, dynamic>>(
        remoteUrl,
        queryParameters: {
          'method': 'track.search',
          'track': track,
          'format': 'json',
          if (artist != null) 'artist': artist,
        },
        timeout: const Duration(seconds: 10),
      );

      if (!response.isSuccessful || response.data == null) {
        return [];
      }

      final results = response.data['results'] as Map<String, dynamic>?;
      if (results == null) return [];

      final trackMatches = results['trackmatches'] as Map<String, dynamic>?;
      if (trackMatches == null) return [];

      final trackList = trackMatches['track'];
      if (trackList == null) return [];

      // 단일 트랙인 경우 List로 변환
      final List<dynamic> tracks = trackList is List ? trackList : [trackList];

      return tracks
          .map((trackJson) {
            try {
              if (trackJson is Map<String, dynamic>) {
                return TrackDto.fromJson(trackJson);
              }
              return null;
            } catch (e) {
              // 개별 파싱 실패 시 스킵
              return null;
            }
          })
          .where((track) => track != null)
          .cast<TrackDto>()
          .toList();
    } on HttpException {
      rethrow;
    }
  }
}
