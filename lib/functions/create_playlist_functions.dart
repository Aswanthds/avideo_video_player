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
      // Add the videoPath to the playlist's videos list
      playlist.videos!.add(videoPath);

      // Update the playlist in the box
      await playlistBox.put(playlistName, playlist);
    }

    // Optional: Print the playlist information
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
      // Remove the videoPath from the playlist's videos list
      playlist.videos!.remove(videoPath);

      // Update the playlist in the box
      await playlistBox.put(playlistName, playlist);
    }

    // Optional: Print the updated playlist information
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
      // Delete the playlist from the box
      await playlistBox.delete(playlistName);

      // Optional: Print a message indicating the deletion
      debugPrint('Deleted playlist: $playlistName');
    } else {
      // Optional: Print an error message if the playlist does not exist
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
        // Create a new playlist with the updated name
        final updatedPlaylist = VideoPlaylist(
          name: newPlaylistName,
          videos: playlist.videos,
        );

        // Put the updated playlist in the box with the new name
        await playlistBox.put(newPlaylistName, updatedPlaylist);

        // Delete the old playlist
        await playlistBox.delete(oldPlaylistName);

        // Optional: Print a message indicating the update
        debugPrint(
            'Updated playlist name: $oldPlaylistName -> $newPlaylistName');
      }
    } else {
      // Optional: Print an error message if the old playlist does not exist
      debugPrint('Playlist not found: $oldPlaylistName');
    }
  }
}
