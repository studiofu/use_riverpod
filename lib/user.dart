// ignore_for_file: public_member_api_docs, sort_constructors_first
// user model
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final int age;
  final String gender;

  const User({
    required this.name,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? name,
    int? age,
    String? gender,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() => 'User(name: $name, age: $age, gender: $gender)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.gender == gender;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ gender.hashCode;
}

// user notifier, contains action to modify user model
class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

  void updateName(String n) {
    state = state.copyWith(name: n);
  }
}
