import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

final userApiModelProvider = Provider<UserApiModel>(
  (ref) => UserApiModel.empty(),
);

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: 'id')
  String? userid;
  String username;
  String? uimage;
  String firstname;
  String lastname;
  String email;
  String? password;

  UserApiModel({
    this.userid,
    required this.username,
    this.uimage,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.password,
  });
  UserApiModel.empty()
      : username = '',
        uimage = '',
        firstname = '',
        lastname = '',
        email = '',
        password = '';

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  UserEntity toEntity() => UserEntity(
        id: userid,
        uimage: uimage,
        username: username,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      );

  UserEntity fromEntity(UserEntity entity) => UserEntity(
        id: entity.id ?? '',
        uimage: entity.uimage,
        username: entity.username,
        firstname: entity.firstname,
        lastname: entity.lastname,
        email: entity.email,
        password: entity.password,
      );

  // Convert AuthApiModel list to AuthEntity list
  List<UserEntity> toEntityList(List<UserApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel(id: $userid, uimage: $uimage, firstname: $firstname, lastname: $lastname, email: $email, password: $password)';
  }
}
