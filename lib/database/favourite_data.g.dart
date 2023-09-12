// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDataAdapter extends TypeAdapter<FavoriteData> {
  @override
  final int typeId = 1;

  @override
  FavoriteData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteData(
      filePath: fields[0] as String,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
