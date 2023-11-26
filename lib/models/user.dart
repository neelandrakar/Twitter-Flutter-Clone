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
  final DateTime? created_at;
  final String? bio;
  final int? hasBlue;
  final String token;
  final String? profilePicture;
  final String? coverPicture;
  final List<String>? followed_by;
  final List<DateTime>? followed_on;
  final List<String>? user_followed;
  final List<DateTime>? user_followed_on;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.mobno,
      required this.birthDate,
      required this.password,
      this.bio,
      this.created_at,
      required this.token,
      this.hasBlue,
      this.profilePicture,
      this.coverPicture,
      this.followed_by,
      this.followed_on,
      this.user_followed,
      this.user_followed_on});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'mobno': mobno,
      'birthDate': birthDate,
      'password': password,
      'bio': bio,
      'created_at': created_at,
      'hasBlue': hasBlue,
      'token': token,
      'profilePicture': profilePicture,
      'coverPicture': coverPicture,
      'followed_on': followed_on,
      'followed_by': followed_by,
      'user_followed': user_followed,
      'user_followed_on': user_followed_on
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
      bio: map['bio'] as String,
      token: map['token'] as String,
      created_at: DateTime.parse(map['created_at']),
      hasBlue: map['hasBlue'] as int,
      profilePicture: map['profilePicture'] as String,
      coverPicture: map['coverPicture'] as String,
      followed_by: List<String>.from(
        (map['followers'] as List).map((like) => like['followed_by'] as String),
      ),
      followed_on: List<DateTime>.from((map['followers'] as List)
          .map((fol) => DateTime.parse(fol['followed_on']))),
      user_followed: List<String>.from(
        (map['following'] as List)
            .map((like) => like['user_followed'] as String),
      ),
      user_followed_on: List<DateTime>.from((map['following'] as List)
          .map((fol2) => DateTime.parse(fol2['user_followed_on']))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? bio,
    DateTime? created_at,
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
      bio: bio ?? this.bio,
      birthDate: birthDate ?? this.birthDate,
      password: password ?? this.password,
      token: token ?? this.token,
      hasBlue: hasBlue ?? this.hasBlue,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
    );
  }
}
