// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_playlist_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoPlaylistAdapter extends TypeAdapter<VideoPlaylist> {
  @override
  final int typeId = 3;

  @override
  VideoPlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPlaylist(
      name: fields[0] as String?,
      videos: (fields[1] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoPlaylist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.videos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
