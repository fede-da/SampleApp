// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String token;
  final String name;
  final int id;

  const User({
    required this.token,
    required this.name,
    required this.id,
  });

  static const User empty = User(token: "token", name: "name", id: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'name': name,
      'id': int.parse("id"),
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      token: json['token'] ?? "token",
      name: json['name'] ?? "name",
      id: json['id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> jsonMap) => User.fromMap(jsonMap);

  @override
  String toString() {
    return token + ' ' + name + ' ' + id.toString() + '\n';
  }

  @override
  List<Object?> get props => [token, name, id];
}
