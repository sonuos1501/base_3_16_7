import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/video_preview/video_preview_screen.dart';
import 'package:theshowplayer/ui/video_preview/video_preview_youtube.dart';
import 'package:theshowplayer/utils/regex/regex.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreenArguments {
  VideoPreviewScreenArguments({
    this.fileName,
    required this.path,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.fullScreenByDefault = false,
    this.allowFullScreen = true,
    this.showControlsOnInitialize = true,
    this.allowMuting = true,
    this.videoPlayerController,
  });

  final String? fileName;
  final String path;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool fullScreenByDefault;
  final bool allowFullScreen;
  final bool showControlsOnInitialize;
  final bool allowMuting;
  final void Function(VideoPlayerController videoPlayerController)?
      videoPlayerController;
}

class VideoAdapterScreen extends StatelessWidget {
  const VideoAdapterScreen({super.key, required this.arguments});

  final VideoPreviewScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    final isYoutube = RegexConstant.isYouTubeLink(arguments.path);

    return isYoutube
      ? YoutubePreview(arguments: arguments)
      : VideoPreview(arguments: arguments);
  }
}
