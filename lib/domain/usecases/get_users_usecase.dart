import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUsecase{
  final UserRepository repository;

  GetUsersUsecase({required this.repository});

  Future<List<User>> execute(String? location, int page) {
    return  repository.getUsers(location, page);
  }
}