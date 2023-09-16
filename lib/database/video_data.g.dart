// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyPlayedDataAdapter extends TypeAdapter<RecentlyPlayedData> {
  @override
  final int typeId = 0;

  @override
  RecentlyPlayedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyPlayedData(
      videoPath: fields[0] as String,
      timestamp: fields[1] as DateTime,
      duration: fields[2] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayedData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyPlayedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
