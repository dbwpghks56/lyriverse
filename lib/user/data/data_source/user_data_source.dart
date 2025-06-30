import 'package:lyriverse/user/data/dto/user_dto.dart';

abstract interface class UserDataSource {
  Future<UserDto> findByEmail(String email);
  Future<UserDto> findById(String id);
}
