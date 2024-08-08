import 'package:flutter/material.dart';
import '../../Domain/entities/user.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text(user.name, style: const TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
            Text('Followers: ${user.followers}', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            ],
              ),
            SizedBox(width: 20),
            Column(
              children: [
            Text('Following: ${user.following}', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            ],
            ),
            ],
            ),
            Divider(),
            SizedBox(height: 20),
            Text(user.bio ?? 'No bio available'),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
