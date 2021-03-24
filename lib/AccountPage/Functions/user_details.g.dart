// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTodoDetailsAdapter extends TypeAdapter<UserTodoDetails> {
  @override
  UserTodoDetails read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTodoDetails()
      ..userName = fields[0] as String
      ..userLoggedDate = fields[1] as DateTime
      ..lastModifedDate = fields[2] as DateTime
      ..chartData = (fields[3] as List)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, UserTodoDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.userLoggedDate)
      ..writeByte(2)
      ..write(obj.lastModifedDate)
      ..writeByte(3)
      ..write(obj.chartData);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
