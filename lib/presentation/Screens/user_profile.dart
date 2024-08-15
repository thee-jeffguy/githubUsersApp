import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_details_usecase.dart';
import '../../data/repository/repository_impl.dart';
import '../../data/data_source/data_source.dart';
import 'package:http/http.dart' as http;

class UserDetailsPage extends StatelessWidget {
  final String login;

  const UserDetailsPage({Key? key, required this.login}) : super(key: key);

  Future<User?> _fetchUserDetails(String login) async {
    final client = http.Client();
    final getUserDetailsUsecase = GetUserDetailsUsecase(
        GitHubRepositoryImpl(GithubDataSource(client)));
    try {
      final user = await getUserDetailsUsecase.call(login);
      return user;
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey.shade200,
      ),
      body: FutureBuilder<User?>(
        future: _fetchUserDetails(login),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error: Failed to load user details.'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                    radius: 60,
                  ),
                  const SizedBox(height: 20),
                  Text(user.name ?? '', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Followers: ${user.followers}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text('Following: ${user.following}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  Text(user.bio ?? 'No bio available'),
                ],
              ),
            );
          }
        },
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
