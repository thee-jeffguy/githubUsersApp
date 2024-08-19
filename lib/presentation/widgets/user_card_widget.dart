import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserCard({Key? key, required this.user, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.name ?? user.login),
        subtitle: Text(user.login),
        onTap: onTap,
      ),
    );
  }
}
