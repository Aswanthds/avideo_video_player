// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoDataAdapter extends TypeAdapter<VideoData> {
  @override
  final int typeId = 0;

  @override
  VideoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoData(
      videoPath: fields[0] as String,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, VideoData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
