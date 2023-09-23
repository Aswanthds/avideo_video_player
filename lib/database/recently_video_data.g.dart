// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_video_data.dart';

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
      current: fields[2] as Duration?,
      full: fields[3] as Duration?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayedData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.current)
      ..writeByte(3)
      ..write(obj.full);
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
