import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetFollowingUsecase {
  final UserRepository repository;

  GetFollowingUsecase(this.repository);

  Future<Future<List<User>>> call(String username) async {
    return repository.getFollowing(username);
  }
}
