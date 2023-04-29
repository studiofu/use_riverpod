// ignore_for_file: public_member_api_docs, sort_constructors_first
// user model
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class User {
  final String? name;
  final String? gender;

  const User({
    required this.name,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? name,
    String? gender,
  }) {
    return User(
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() => 'User(name: $name, gender: $gender)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.gender == gender;
  }

  @override
  int get hashCode => name.hashCode ^ gender.hashCode;
}

// user notifier, contains action to modify user model
class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

  void updateName(String n) {
    state = state.copyWith(name: n);
  }
}

// create user repository to simulate http call and get data
class UserRepository {
  Future<User> fetchUserData() {
    const url = 'https://jsonplaceholder.typicode.com/users/3';
    // http.get return future of repsonse,
    // after then , return future of User
    return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
  }
}
