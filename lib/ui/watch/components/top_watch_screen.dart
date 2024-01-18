
import 'package:flutter/material.dart';
// import 'package:html/dom.dart' as htmlParser;

import '../../video_preview/video_adapter_screen.dart';
import '../../video_preview/video_preview_screen.dart';

class TopWatchScreen extends StatelessWidget {
  const TopWatchScreen({ super.key, required this.videoLocation });

  final String videoLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 215,
          child: VideoPreview(
            arguments: VideoPreviewScreenArguments(
              path: videoLocation,
              autoPlay: true,
              allowFullScreen: true,
            ),
          ),
        ),
      ],
    );
  }
}
