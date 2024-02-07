// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 0;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      userid: fields[0] as String?,
      username: fields[1] as String,
      uimage: fields[2] as String,
      firstname: fields[3] as String,
      lastname: fields[4] as String,
      email: fields[5] as String,
      password: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.uimage)
      ..writeByte(3)
      ..write(obj.firstname)
      ..writeByte(4)
      ..write(obj.lastname)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
