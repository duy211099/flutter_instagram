import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;
  final int followers;
  final int following;
  final String bio;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
    required this.bio,
  });

  static const empty = User(
      id: '',
      username: '',
      email: '',
      profileImageUrl: '',
      followers: 0,
      following: 0,
      bio: '');

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImageUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      followers: data['followers']?.toInt() ?? 0,
      following: data['following']?.toInt() ?? 0,
      bio: data['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toDocument());

  factory User.fromJson(String source) =>
      User.fromDocument(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, profileImageUrl: $profileImageUrl, followers: $followers, following: $following, bio: $bio)';
  }

  @override
  List<Object> get props {
    return [
      id,
      username,
      email,
      profileImageUrl,
      followers,
      following,
      bio,
    ];
  }
}
