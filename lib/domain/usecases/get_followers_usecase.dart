import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetFollowersUsecase {
  final UserRepository repository;

  GetFollowersUsecase(this.repository);

  Future<Future<List<User>>> call(String username) async {
    return repository.getFollowers(username);
  }
}
