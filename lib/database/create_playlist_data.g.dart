// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_playlist_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreatePlaylistDataAdapter extends TypeAdapter<CreatePlaylistData> {
  @override
  final int typeId = 3;

  @override
  CreatePlaylistData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreatePlaylistData(
      filePath: fields[0] as String,
      timestamp: fields[1] as DateTime,
      name: fields[2] as String,
      path: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreatePlaylistData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatePlaylistDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
