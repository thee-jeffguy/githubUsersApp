

import 'package:test_drive/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class SearchUsersByUsernameUsecase{
  final UserRepository userRepository;

  SearchUsersByUsernameUsecase(this.userRepository);

  Future<List<User>> execute(String? username, int page) {
    return userRepository.searchUsersByUsername(username, page);
  }
}