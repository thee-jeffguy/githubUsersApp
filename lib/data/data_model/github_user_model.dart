import '../../domain/entities/user.dart';

class GithubUserModel extends User {
  GithubUserModel(
      {required super.login,
      required super.name,
      required super.avatarUrl,
      required super.followers,
      required super.following,
      required super.bio,
      required super.type});

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
        login: json['login'],
        name: json['name'] ?? '',
        avatarUrl: json['avatarUrl'],
        followers: json['followers'],
        following: json['following'],
        bio: json['bio'] ?? '',
        type: json['type']);
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
