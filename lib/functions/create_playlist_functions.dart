import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/create_playlist_data.dart';

class CreatePlayListFunctions {
  static Future<void> createPlaylist(String? playlistName) async {
    final Box<CreatePlaylistData> playlistBox =
        await Hive.openBox<CreatePlaylistData>('playlists');

    final playlist = CreatePlaylistData(name: playlistName);
    await playlistBox.add(playlist);
  }

  static Future<void> addVideoToPlaylist(
      String playlistName, String videoPath) async {
    debugPrint('$videoPath is @ $playlistName');
  }
}
