import 'package:lyriverse/user/data/data_source/user_data_source.dart';
import 'package:lyriverse/user/data/mapper/user_mapper.dart';
import 'package:lyriverse/user/domain/model/user_model.dart';
import 'package:lyriverse/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  const UserRepositoryImpl({required UserDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<UserModel> findByEmail(String email) async {
    return (await _dataSource.findByEmail(email)).toModel();
  }

  @override
  Future<UserModel> findById(String id) async {
    return (await _dataSource.findById(id)).toModel();
  }
}
