import 'package:lyriverse/user/domain/model/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel> findByEmail(String email);
  Future<UserModel> findById(String id);
}
