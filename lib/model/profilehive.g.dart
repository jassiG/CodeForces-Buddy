// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilehive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveAdapter extends TypeAdapter<ProfileHive> {
  @override
  final int typeId = 0;

  @override
  ProfileHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHive(
      handle: fields[0] as String,
      rating: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.handle)
      ..writeByte(1)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
