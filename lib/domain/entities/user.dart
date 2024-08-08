
class User {
  final String login;
  final String name;
  final String avatarUrl;
  int? followers;
  int? following;
  String? bio;
  String? type;

  User({
    required this.login,
    required this.name,
    required this.avatarUrl,
    this.followers,
    this.following,
    this.bio,
    this.type,
  });
}
