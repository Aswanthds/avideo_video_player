import 'dart:io';

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

      // Check if the video path already exists in the playlist
      if (!playlist.videos!.contains(videoPath)) {
        // Check if the video file exists before adding it
        final videoFile = File(videoPath);
        if (videoFile.existsSync()) {
          playlist.videos!.add(videoPath);
          await playlistBox.put(playlistName, playlist);
        } else {
          // Video file doesn't exist, so don't add it
          // Optionally, you can display a message or handle it as needed
          debugPrint('Video file does not exist: $videoPath');
        }
      } else {
        // Video path already exists in the playlist, handle it as needed
        debugPrint('Video already exists in the playlist: $videoPath');
        // Optionally, you can display a message or handle it as needed
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
      // Retrieve the playlist
      final playlist = playlistBox.get(playlistName);

      if (playlist != null) {
        // Remove video paths associated with the playlist from Hive
        for (final videoPath in playlist.videos ?? []) {
          final videoBox = Hive.box<List<String>>('videos');
          for (var videoList in videoBox.values) {
            videoList.remove(videoPath);
          }
        }
      }

      // Delete the playlist from Hive
      await playlistBox.delete(playlistName);

      debugPrint('Deleted playlist: $playlistName');
    } else {
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
