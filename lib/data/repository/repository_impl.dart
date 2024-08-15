import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_drive/domain/entities/user.dart';
import 'package:test_drive/domain/repositories/user_repository.dart';
import '../data_model/github_user_model.dart';
import '../data_source/data_source.dart';


class GitHubRepositoryImpl implements UserRepository{
  final GithubDataSource remoteGithubDataSource;

  GitHubRepositoryImpl(this.remoteGithubDataSource);

  @override
  Future<List<User>> getUsers(String? location, int? page) async{
    List<GithubUserModel> userModels = await remoteGithubDataSource.fetchUsers(location, page);

    return  userModels.map((userModel) => userModel.toEntity()).toList() ;

  }

  @override
  Future<List<User>> searchUsersByUsername(String? username, int page) async {
    final users = await remoteGithubDataSource.searchUsersByUsername(username, page);
    return users.map((user) => user.toEntity()).toList();
  }

  @override
  Future<User> getUserDetails(String? login) async{
    final userDetails = await remoteGithubDataSource.getUserDetails(login);
    return userDetails.toEntity();
  }
}
