import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_model/github_user_model.dart';

 class GithubDataSource{
  Future<List<GithubUserModel>> fetchUsers(
      String? location, int page) async {
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
}