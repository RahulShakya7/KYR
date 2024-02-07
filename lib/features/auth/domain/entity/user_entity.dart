import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String username;
  final String? uimage;
  final String firstname;
  final String lastname;
  final String email;
  final String? password;

  const UserEntity({
    this.id,
    required this.username,
    this.uimage,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.password,
  });

  UserEntity copyWith({
    String? id,
    String? username,
    String? uimage,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      uimage: uimage ?? this.uimage,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        username: json["username"],
        uimage: json["uimage"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "uimage": uimage,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [username, firstname, lastname, email, password];
}
