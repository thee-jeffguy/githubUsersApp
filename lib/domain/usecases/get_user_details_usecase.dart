
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetailsUsecase{
  final UserRepository repository;

   GetUserDetailsUsecase(this.repository);

  Future<User> call(String login) async{
    return await repository.getUserDetails(login);
  }
}

