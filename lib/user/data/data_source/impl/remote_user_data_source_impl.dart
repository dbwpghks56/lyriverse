import 'package:lyriverse/user/data/data_source/user_data_source.dart';
import 'package:lyriverse/user/data/dto/user_dto.dart';

class RemoteUserDataSourceImpl implements UserDataSource {
  @override
  Future<UserDto> findByEmail(String email) {
    // TODO: implement findByEmail
    throw UnimplementedError();
  }

  @override
  Future<UserDto> findById(String id) {
    // TODO: implement findByid
    throw UnimplementedError();
  }
}
