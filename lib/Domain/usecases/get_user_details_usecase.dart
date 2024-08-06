import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetailsUsecase{
  final UserRepository repository;

  GetUserDetailsUsecase({required this.repository});

  Future<List<User>> execute(String? location, int page) {
    return repository.getUserDetails(location, page);
  }
}