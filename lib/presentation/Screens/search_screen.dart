import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_drive/data/data_source/data_source.dart';
import 'package:test_drive/data/repository/repository_impl.dart';
import 'package:test_drive/domain/entities/user.dart';
import 'package:test_drive/domain/usecases/get_user_details_usecase.dart';
import '../providers/user_details_provider.dart';
import 'user_profile.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GetUserDetailsUsecase getUserDetails = GetUserDetailsUsecase(GitHubRepositoryImpl(GithubDataSource()));

  List<User> _searchResults = [];

  Future<void> _search() async {
    final query = _searchController.text;
    if (query.isEmpty) return;

    final url = Uri.parse('https://api.github.com/search/users?q=location:$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = (data['items'] as List).map((item) {
        return User(
          login: item['login'],
          name: item['login'],  // Use 'login' as a fallback for name
          avatarUrl: item['avatar_url'],
          bio: '',
          type: '', // Initialize as empty or fetch later
        );
      }).toList();
      setState(() {
        _searchResults = items;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _getUserDetails(String login) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    userDetailsProvider.getUserDetails(login).then((_) {
      if (userDetailsProvider.userDetails != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetails(user:userDetailsProvider.userDetails!)),
        );
      } else if (userDetailsProvider.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user details: ${userDetailsProvider.error}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search GitHub Users',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _search(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final user = _searchResults[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.login),
                  onTap: () {
                    _getUserDetails(user.login);
                  },
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
    );
  }
}
