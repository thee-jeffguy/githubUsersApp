import 'dart:async';

import '../../Domain/repositories/user_repository.dart';
import '../../Domain/entities/user.dart';
import '../../Data/data_model/github_user_model.dart';
import '../../Data/data_source/data_source.dart';

class GitHubRepositoryImpl implements UserRepository{
  final GithubDataSource remoteGithubDataSource;

  GitHubRepositoryImpl(this.remoteGithubDataSource);

  @override
  Future<List<User>> getUserDetails(String? location, int page) async{
    List<GithubUserModel> userModels = await remoteGithubDataSource.fetchUsers(location, page);

    return  Future.value(userModels.map((userModel) => userModel.toEntity()).toList() as FutureOr<List<User>>?);

  }

}