import 'dart:convert';

import '../../domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_user_model.g.dart';

@JsonSerializable()

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
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'],
      type: json['type'],
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

