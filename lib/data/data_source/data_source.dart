import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_model/github_user_model.dart';

 class GithubDataSource{
   Future<List<GithubUserModel>> fetchUsers(String? location, int? page) async {
     // Ensure that location and page are properly handled
     String baseUrl = "https://api.github.com/search/users?q=location:";
     String locationPart = location ?? "";
     String pagePart = (page != null && page > 0) ? "&page=$page" : "";

     String url = "$baseUrl$locationPart$pagePart";


     if (url.isEmpty) {
       throw Exception('URL cannot be null or empty');
     }

     final response = await http.get(Uri.parse(url));

     if (response.statusCode == 200) {
       final data = json.decode(response.body);

       // Ensure that 'items' exists and is not null in the response
       if (data['items'] != null) {
         return (data['items'] as List)
             .map((item) => GithubUserModel.fromJson(item)).toList();
       } else {
         throw Exception('No users found in the response');
       }
     } else {
       throw Exception('Failed to load Github Users: ${response.reasonPhrase}');
     }
   }

   Future<GithubUserModel> getUserDetails(String? login) async {
     final url = Uri.parse('https://api.github.com/users/$login');
     final response = await http.get(url);

     if (response.statusCode == 200) {
       final data = json.decode(response.body);

       // Directly convert the data to a GithubUserModel
       return GithubUserModel.fromJson(data);
     } else {
       throw Exception('Failed to load user details');
     }
   }

   final http.Client client;

   GithubDataSource(this.client);

   Future<List<GithubUserModel>> searchUsersByUsername(String? username, int page) async {
     final url = Uri.parse('https://api.github.com/search/users?q=$username&page=$page');
     final response = await client.get(url);

     if (response.statusCode == 200) {
       final data = json.decode(response.body);
       return (data['items'] as List).map((item) => GithubUserModel.fromJson(item)).toList();
       } else {
       throw Exception('Failed to search users by username');
     }
   }


   Future<List<GithubUserModel>> getFollowers(String username) async {
     final response = await client.get(
       Uri.parse('https://api.github.com/users/$username/followers'),
       headers: {'Accept': 'application/vnd.github.v3+json'},
     );

     if (response.statusCode == 200) {
       final List<dynamic> data = json.decode(response.body);
       return data.map((user) => GithubUserModel.fromJson(user)).toList();
     } else {
       throw Exception('Failed to load Followers'); // Handle errors
     }
   }

   Future<List<GithubUserModel>> getFollowing(String username) async {
     final response = await client.get(
       Uri.parse('https://api.github.com/users/$username/following'),
       headers: {'Accept': 'application/vnd.github.v3+json'},
     );

     if (response.statusCode == 200) {
       final List<dynamic> data = json.decode(response.body);
       return data.map((user) => GithubUserModel.fromJson(user)).toList();
     } else {
       throw Exception('Failed to load Following'); // Handle errors
     }
   }
 }




