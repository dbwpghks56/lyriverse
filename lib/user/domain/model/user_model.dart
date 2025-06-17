import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  final String id;
  final String email;
  final String displayName;
  final String imageSource;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.imageSource,
  });
}
