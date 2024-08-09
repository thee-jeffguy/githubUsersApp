import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_model/github_user_model.dart';

 class GithubDataSource{
  Future<List<GithubUserModel>> fetchUsers(
      String? location, int? page) async {
    String url = (location != null)
        ? "https://api.github.com/search/users?q=location:$location&page"
    :"https://api.github.com/search/users?q=location:""";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List)
          .map((item) => GithubUserModel.fromJson(item))
          .toList();
    }
    else {
      throw Exception('Failed to load Github Users: ${response.reasonPhrase}');
    }
  }

  Future<List<GithubUserModel>> getUserDetails(String? login) async{
    final url = Uri.parse('https://api.github.com/users/$login');
    final response = await http.get(url);

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      return (data['items'] as List)
          .map((item) => GithubUserModel.fromJson(item))
          .toList();
        // login: data['login'],
        // name: data['name'],
        // avatarUrl: data['avatar_url'],
        // followers: data['followers'],
        // following: data['following'],
        // bio: data['bio'],
        // type: data['type'],
      // );
    }else {
      throw Exception('Failed to load user details');
    }
  }
 }
