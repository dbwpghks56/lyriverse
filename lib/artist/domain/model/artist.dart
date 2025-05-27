import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';

@freezed
class Artist with _$Artist {
  @override
  final String name;
  @override
  final String url;

  const Artist({
    required this.name,
    required this.url,
  });
}
