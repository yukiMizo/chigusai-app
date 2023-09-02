import 'package:flutter/material.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'theme_song_manager.dart';

import 'package:chigusai_app/data/theme_song_data.dart';

class ThemeSongScreen extends StatefulWidget {
  static const routeName = "/theme-song-screen";
  const ThemeSongScreen({super.key});

  @override
  State<ThemeSongScreen> createState() => _ThemeSongScreenState();
}

class _ThemeSongScreenState extends State<ThemeSongScreen> {
  late final ThemeSongManager _themeSongManager;

  @override
  void initState() {
    super.initState();
    _themeSongManager = ThemeSongManager();
  }

  @override
  void dispose() {
    _themeSongManager.dispose();
    super.dispose();
  }

  Widget _buildProgressBar() {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _themeSongManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _themeSongManager.seek,
        );
      },
    );
  }

  Widget _buildPlayButton() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _themeSongManager.buttonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _themeSongManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _themeSongManager.pause,
            );
        }
      },
    );
  }

  Widget _buildLyrics() {
    const List<String> lyricsList = ThemeSongData.lyricsList;
    return Scrollbar(
      child: ListView.builder(
        itemCount: lyricsList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lyricsList[index]),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("テーマソング再生")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            const Text(
              ThemeSongData.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              ThemeSongData.bandName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildLyrics()),
            const SizedBox(height: 20),
            _buildProgressBar(),
            _buildPlayButton(),
          ],
        ),
      ),
    );
  }
}
