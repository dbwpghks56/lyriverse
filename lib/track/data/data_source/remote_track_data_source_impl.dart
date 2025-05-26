import 'package:dio/dio.dart';
import 'package:lyriverse/core/data_source/dio/dio_data_source.dart';
import 'package:lyriverse/track/data/dto/track_dto.dart';
import 'package:lyriverse/track/domain/data_source/track_data_source.dart';

class RemoteTrackDataSourceImpl implements TrackDataSource {
  final DioDataSource remoteDataSource;
  final String remoteUrl;

  const RemoteTrackDataSourceImpl({
    required this.remoteDataSource,
    required this.remoteUrl,
  });

  @override
  Future<List<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
  }) async {
    final Response response = await remoteDataSource.get(
      remoteUrl,
      queryParameters: {
        'method': 'track.search',
        'track': track,
        'format': 'json',
        'artist': artist,
      },
    );

    final List<dynamic> trackList =
        response.data['results']['trackmatches']['track'];

    List<TrackDto> trackDtos =
        trackList
            .map(
              (track) => TrackDto.fromJson(track),
            )
            .toList();

    return trackDtos;
  }
}
