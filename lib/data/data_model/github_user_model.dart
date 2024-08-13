import 'dart:convert';

import '../../domain/entities/user.dart';

class GithubUserModel extends User {
  GithubUserModel({
    required String login,
    required String avatarUrl,
    String? name,
    int? followers,
    int? following,
    String? bio,
    String? type,
  }) : super(
    login: login,
    name: name ?? '',
    avatarUrl: avatarUrl,
    followers: followers ?? 0,
    following: following ?? 0,
    bio: bio ?? '',
    type: type ?? '',
  );

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      login: json['login'] ?? '',  // Ensuring login is never null
      avatarUrl: json['avatar_url'] ?? '',  // Using the correct JSON key for avatar URL
      name: json['name'],  // Name can be null, handled in the constructor
      followers: json['followers'],  // Followers can be null, handled in the constructor
      following: json['following'],  // Following can be null, handled in the constructor
      bio: json['bio'],  // Bio can be null, handled in the constructor
      type: json['type'],  // Type can be null, handled in the constructor
    );
  }

  User toEntity() {
    return User(
      login: login,
      name: name,
      avatarUrl: avatarUrl,
      followers: followers,
      following: following,
      bio: bio,
      type: type,
    );
  }
}

