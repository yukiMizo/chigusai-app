/*import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ShowPRVideoScreen extends StatefulWidget {
  static const routeName = "/show-pr-video-screen";
  const ShowPRVideoScreen({super.key});

  @override
  State<ShowPRVideoScreen> createState() => _ShowPRVideoScreenState();
}

class _ShowPRVideoScreenState extends State<ShowPRVideoScreen> {
//コントローラーの定義
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/videos/101.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2, //アスペクト比
      autoPlay: false, //自動再生
      looping: true, //繰り返し再生

      // 以下はオプション（なくてもOK）
      showControls: false, //コントロールバーの表示（デフォルトではtrue）
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red, //再生済み部分（左側）の色
        handleColor: Colors.blue, //再生地点を示すハンドルの色
        backgroundColor: Colors.grey, //再生前のプログレスバーの色
        bufferedColor: Colors.lightGreen, //未再生部分（右側）の色
      ),
      placeholder: Container(
        color: Colors.grey, //動画読み込み前の背景色
      ),
      autoInitialize: true, //widget呼び出し時に動画を読み込むかどうか
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PR動画再生")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/