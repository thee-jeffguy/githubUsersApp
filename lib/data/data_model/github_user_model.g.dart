// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUserModel _$GithubUserModelFromJson(Map<String, dynamic> json) =>
    GithubUserModel(
      login: json['login'] as String,
      avatarUrl: json['avatarUrl'] as String,
      name: json['name'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$GithubUserModelToJson(GithubUserModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'followers': instance.followers,
      'following': instance.following,
      'bio': instance.bio,
      'type': instance.type,
    };
