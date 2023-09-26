import 'package:hive_flutter/hive_flutter.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 5; //

  @override
  Duration read(BinaryReader reader) {
    final millis = reader.readInt();
    return Duration(milliseconds: millis);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMilliseconds);
  }
}
