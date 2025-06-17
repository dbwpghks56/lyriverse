import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDto {
  final String? id;
  final String? email;
  final String? displayName;
  final String? imageSource;

  const UserDto({
    required this.id,
    required this.email,
    required this.displayName,
    required this.imageSource,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
