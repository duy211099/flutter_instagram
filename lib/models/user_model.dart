import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userName;
  final String email;
  final String profileImageUrl;
  final int followers;
  final int following;
  final String bio;

  const User({
    required this.id,
    required this.userName,
    required this.email,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
    required this.bio,
  });

  static const empty = User(
      id: '',
      userName: '',
      email: '',
      profileImageUrl: '',
      followers: 0,
      following: 0,
      bio: '');

  User copyWith({
    String? id,
    String? userName,
    String? email,
    String? profileImageUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
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
      'userName': userName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'] ?? '',
      userName: doc['userName'] ?? '',
      email: doc['email'] ?? '',
      profileImageUrl: doc['profileImageUrl'] ?? '',
      followers: doc['followers']?.toInt() ?? 0,
      following: doc['following']?.toInt() ?? 0,
      bio: doc['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toDocument());

  factory User.fromJson(String source) =>
      User.fromDocument(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, email: $email, profileImageUrl: $profileImageUrl, followers: $followers, following: $following, bio: $bio)';
  }

  @override
  List<Object> get props {
    return [
      id,
      userName,
      email,
      profileImageUrl,
      followers,
      following,
      bio,
    ];
  }
}
