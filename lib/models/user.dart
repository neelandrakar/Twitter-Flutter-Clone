import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final int mobno;
  final String birthDate;
  final String password;
  final int? hasBlue;
  final String token;
  final String? profilePicture;
  final String? coverPicture;
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.mobno,
    required this.birthDate,
    required this.password,
    required this.token,
    this.hasBlue,
    this.profilePicture,
    this.coverPicture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'mobno': mobno,
      'birthDate': birthDate,
      'password': password,
      'hasBlue': hasBlue,
      'token': token,
      'profilePicture': profilePicture,
      'coverPicture': coverPicture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      mobno: map['mobno'] as int,
      birthDate: map['birthDate'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      hasBlue: map['hasBlue'] as int,
      profilePicture: map['profilePicture'] as String,
      coverPicture: map['coverPicture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    int? mobno,
    String? birthDate,
    String? password,
    String? token,
    int? hasBlue,
    String? profilePicture,
    String? coverPicture,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      mobno: mobno ?? this.mobno,
      birthDate: birthDate ?? this.birthDate,
      password: password ?? this.password,
      token: token ?? this.token,
      hasBlue: hasBlue ?? this.hasBlue,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
    );
  }
}
