import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Video {
  @HiveField(1)
  final String filePath;

  Video({required this.filePath});
}
