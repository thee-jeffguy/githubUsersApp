import '../entities/user.dart';

abstract class UserRepository{
  Future<List<User>> getUserDetails(String? location, int page);
}
