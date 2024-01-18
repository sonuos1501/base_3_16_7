// ignore_for_file: unused_shown_name

import 'dart:io' show File, Platform;

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/video_preview/video_adapter_screen.dart';
import 'package:theshowplayer/utils/videos/videos.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatelessWidget {
  const VideoPreview({super.key, required this.arguments});

  final VideoPreviewScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    return _VideoPreviewBody(arguments: arguments);
  }
}

class _VideoPreviewBody extends StatefulWidget {
  const _VideoPreviewBody({required this.arguments});

  final VideoPreviewScreenArguments arguments;

  @override
  State<_VideoPreviewBody> createState() => _VideoPreviewBodyState();
}

class _VideoPreviewBodyState extends State<_VideoPreviewBody> {
  VideoPlayerController? _videoPlayerController;
  late FlickManager _flickManager;

  Future<void> _initPlayer() async {
    final path = await VideoUtils.convertToMp4(widget.arguments.path);
    if (Uri.parse(path).isAbsolute) {
      _videoPlayerController = VideoPlayerController.network(path);
    } else {
      _videoPlayerController = VideoPlayerController.file(File(path));
    }

    _flickManager = FlickManager(videoPlayerController: _videoPlayerController!);

    if (widget.arguments.looping) {
      await _videoPlayerController!.setLooping(true);
    }

    if (widget.arguments.videoPlayerController != null) {
      widget.arguments.videoPlayerController!(_videoPlayerController!);
    }

    await _videoPlayerController!.play();
    setState(() {});

  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController != null
      ? FlickVideoPlayer(
        flickManager: _flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          controls: widget.arguments.showControls
            ? FlickPortraitControls(
              progressBarSettings: FlickProgressBarSettings(playedColor: Colors.red),
            )
            : null,
        ),
      )
      : const Center(child: LoadingView());
  }

}
