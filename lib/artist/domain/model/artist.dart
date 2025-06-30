import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';

@freezed
class Artist with _$Artist {
  final String id;
  final String href;
  @override
  final String name;
  final String type;

  const Artist({
    required this.id,
    required this.href,
    required this.name,
    required this.type,
  });
}
