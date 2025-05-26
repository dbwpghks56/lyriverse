import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';

@freezed
class Artist with _$Artist {
  final String name;
  final String url;

  const Artist({
    required this.name,
    required this.url,
  });
}
