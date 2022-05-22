// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_routing_session_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoutingSessionHistoryModelAdapter
    extends TypeAdapter<UserRoutingSessionHistoryModel> {
  @override
  final int typeId = 2;

  @override
  UserRoutingSessionHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRoutingSessionHistoryModel(
      uid: fields[0] as String?,
      average: fields[1] as double?,
      date: fields[2] as DateTime?,
      exerciseCount: fields[3] as int?,
      longestRound: fields[4] as double?,
      likes: fields[5] as int?,
      sessionType: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserRoutingSessionHistoryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.average)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.exerciseCount)
      ..writeByte(4)
      ..write(obj.longestRound)
      ..writeByte(5)
      ..write(obj.likes)
      ..writeByte(6)
      ..write(obj.sessionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoutingSessionHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
