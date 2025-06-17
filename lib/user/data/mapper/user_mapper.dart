import 'package:lyriverse/user/data/dto/user_dto.dart';
import 'package:lyriverse/user/domain/model/user_model.dart';

extension UserMapper on UserDto {
  UserModel toModel() {
    return UserModel(
      id: id ?? 'N/A',
      displayName: displayName ?? 'N/A',
      email: email ?? 'N/A',
      imageSource: imageSource ?? 'N/A',
    );
  }
}
