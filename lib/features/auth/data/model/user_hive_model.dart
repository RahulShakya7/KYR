import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => UserHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String userid;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String uimage;

  @HiveField(3)
  final String firstname;

  @HiveField(4)
  final String lastname;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String password;

  UserHiveModel({
    String? userid,
    required this.username,
    required this.uimage,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  }) : userid = userid ?? const Uuid().v4();

  UserHiveModel.empty()
      : this(
          username: '',
          uimage: '',
          firstname: '',
          lastname: '',
          email: '',
          password: '',
        );

  UserEntity toEntity() => UserEntity(
        id: userid,
        username: username,
        uimage: uimage,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      );

  UserHiveModel toHiveModel(UserEntity entity) => UserHiveModel(
        userid: entity.id,
        username: entity.username,
        uimage: entity.uimage ?? '',
        firstname: entity.firstname,
        lastname: entity.lastname,
        email: entity.email,
        password: entity.password ?? '',
      );

  List<UserHiveModel> toHiveModelList(List<UserEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'id: $userid, uimage: $uimage, firstname: $firstname, lastname: $lastname, email: $email, password: $password';
  }
}
