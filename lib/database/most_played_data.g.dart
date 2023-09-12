// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_played_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostlyPlayedDataAdapter extends TypeAdapter<MostlyPlayedData> {
  @override
  final int typeId = 2;

  @override
  MostlyPlayedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostlyPlayedData(
      videoPath: fields[0] as String?,
      playCount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MostlyPlayedData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.playCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostlyPlayedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
