class User {
  final String login;
  final String name;
  final String avatarUrl;
  final int? followers;
  final int? following;
  final String? bio;
  final String? type;
  final String? htmlUrl;

  User({
    required this.login,
    required this.name,
    required this.avatarUrl,
    this.followers,
    this.following,
    this.bio,
    this.type,
    this.htmlUrl,
  });
}
