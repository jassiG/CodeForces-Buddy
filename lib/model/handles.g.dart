// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handles.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HandlesAdapter extends TypeAdapter<Handles> {
  @override
  final int typeId = 1;

  @override
  Handles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Handles(
      users: (fields[0] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Handles obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.users);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HandlesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
