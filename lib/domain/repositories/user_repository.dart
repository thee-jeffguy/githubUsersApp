import 'package:test_drive/domain/entities/user.dart';

abstract class UserRepository{
  Future<List<User>> getUsers(String? location, int page);
  Future<User> getUserDetails(String? login);
  Future<List<User>> searchUsersByUsername(String? username, int page);
}
