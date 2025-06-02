import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/models/http_response.dart';
import 'package:lyriverse/lyric/data/data_source/lyric_data_source.dart';
import 'package:lyriverse/lyric/data/dto/lyric_dto.dart';

class RemoteLyricDataSource implements LyricDataSource {
  final HttpClient _httpClient;
  final String remoteUrl;

  const RemoteLyricDataSource({
    required HttpClient httpClient,
    required this.remoteUrl,
  }) : _httpClient = httpClient;

  @override
  Future<LyricDto> findLyricByTrackAndArtist({
    required String track,
    required String artist,
  }) async {
    try {
      final HttpResponse response = await _httpClient.get(
        remoteUrl,
        queryParameters: {
          'artist_name': artist,
          'track_name': track,
        },
      );

      return LyricDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
