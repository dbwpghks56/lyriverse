import 'package:freezed_annotation/freezed_annotation.dart';

part 'lyric.freezed.dart';

@freezed
class Lyric with _$Lyric {
  final int id;
  final String name;
  final String trackName;
  final String artistName;
  final String albumName;
  final String plainLyrics;

  const Lyric({
    required this.id,
    required this.name,
    required this.trackName,
    required this.artistName,
    required this.albumName,
    required this.plainLyrics,
  });
}
