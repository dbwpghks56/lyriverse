import 'package:lyriverse/track/data/dto/track_dto.dart';

abstract interface class TrackDataSource {
  Future<List<TrackDto>> findTracksByArtistAndName({
    required String track,
    String? artist,
  });
}
