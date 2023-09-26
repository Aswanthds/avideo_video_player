import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/create_playlist_data.dart';

class CreatePlayListFunctions {
  static Future<void> createPlaylist(String? playlistName) async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');

    final playlist = VideoPlaylist(name: playlistName!, videos: []);
    await playlistBox.put(playlistName, playlist);
  }

  static Future<void> addVideoToPlaylist(
      String playlistName, String videoPath) async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');

    final playlist = playlistBox.get(playlistName);

    if (playlist != null) {
      playlist.videos ??= [];
      //
      playlist.videos!.add(videoPath);

      //
      await playlistBox.put(playlistName, playlist);
    }

    //
    if (playlist != null) {
      debugPrint('Playlist Name: ${playlist.name}');
      debugPrint('Videos:');
      if (playlist.videos != null) {
        for (var video in playlist.videos!) {
          debugPrint(video);
        }
      }
    }
  }

  static Future<void> deleteVideoFromPlaylist(
      String playlistName, String videoPath) async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');

    final playlist = playlistBox.get(playlistName);

    if (playlist != null && playlist.videos != null) {
      //
      playlist.videos!.remove(videoPath);

      //
      await playlistBox.put(playlistName, playlist);
    }

    //
    if (playlist != null) {
      debugPrint('Playlist Name: ${playlist.name}');
      debugPrint('Updated Videos:');
      if (playlist.videos != null) {
        for (var video in playlist.videos!) {
          debugPrint(video);
        }
      }
    }
  }

  static Future<void> deletePlaylist(String playlistName) async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');

    if (playlistBox.containsKey(playlistName)) {
      //
      await playlistBox.delete(playlistName);

      //
      debugPrint('Deleted playlist: $playlistName');
    } else {
      //
      debugPrint('Playlist not found: $playlistName');
    }
  }

  static Future<void> updatePlaylistName(
      String oldPlaylistName, String newPlaylistName) async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');

    if (playlistBox.containsKey(oldPlaylistName)) {
      final playlist = playlistBox.get(oldPlaylistName);

      if (playlist != null) {
        //
        final updatedPlaylist = VideoPlaylist(
          name: newPlaylistName,
          videos: playlist.videos,
        );

        //
        await playlistBox.put(newPlaylistName, updatedPlaylist);

        //
        await playlistBox.delete(oldPlaylistName);

        //
        debugPrint(
            'Updated playlist name: $oldPlaylistName -> $newPlaylistName');
      }
    } else {
      //
      debugPrint('Playlist not found: $oldPlaylistName');
    }
  }
}
