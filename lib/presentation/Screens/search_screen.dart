import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/presentation/providers/user_provider.dart';
import '../providers/user_details_provider.dart';
import 'user_profile.dart';
import '../providers/connectivity_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isSearchingByLocation = true;

  @override
  void initState() {
    super.initState();
    _loadDefaultUsers();

    _locationController.addListener(() {
      if (_locationController.text.isNotEmpty) {
        _isSearchingByLocation = true;
        _usernameController.clear();
        _searchByLocation();
      }
    });

    _usernameController.addListener(() {
      if (_usernameController.text.isNotEmpty) {
        _isSearchingByLocation = false;
        _locationController.clear();
        _searchByUsername();
      }
    });

    Provider.of<InternetConnectionProvider>(context, listen: false)
        .addListener(_onConnectivityChange);
  }

  @override
  void dispose() {
    _locationController.dispose();
    _usernameController.dispose();
    Provider.of<InternetConnectionProvider>(context, listen: false)
        .removeListener(_onConnectivityChange);
    super.dispose();
  }

  void _onConnectivityChange() {
    final internetProvider =
    Provider.of<InternetConnectionProvider>(context, listen: false);
    if (!internetProvider.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection')),
      );
    }
  }

  Future<void> _loadDefaultUsers() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final internetProvider =
    Provider.of<InternetConnectionProvider>(context, listen: false);

    if (await internetProvider.hasInternetConnection()) {
      await userProvider.getUsers('', 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Internet connection lost')),
      );
    }
  }

  Future<void> _searchByLocation() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final internetProvider =
    Provider.of<InternetConnectionProvider>(context, listen: false);

    if (await internetProvider.hasInternetConnection()) {
      userProvider.resetSearchState();
      await userProvider.getUsers(_locationController.text, 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection')),
      );
    }
  }

  Future<void> _searchByUsername() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final internetProvider =
    Provider.of<InternetConnectionProvider>(context, listen: false);

    if (await internetProvider.hasInternetConnection()) {
      userProvider.resetSearchState();
      await userProvider.searchUsersByUsername(_usernameController.text, 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection')),
      );
    }
  }

  void _getUserDetails(String login) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserDetailsPage(login: login),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Users App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey.shade200,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                hintText: 'Search by location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchByLocation(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Search by username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchByUsername(),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent &&
                    !userProvider.isLoadingMore &&
                    userProvider.hasMore) {
                  if (_isSearchingByLocation) {
                    userProvider.loadMoreUsers(_locationController.text);
                  } else {
                    userProvider.loadMoreUsersByUsername(
                        _usernameController.text);
                  }
                }
                return true;
              },
              child: ListView.builder(
                itemCount: users.length + (userProvider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == users.length && userProvider.isLoadingMore) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final user = users[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      onTap: () => _getUserDetails(user.login),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.login),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
