// import 'dart:io';

// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import '../utils.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../regex/regex.dart';

abstract class VideoUtils {
  static Future<String> convertToMp4(String videoUrl) async {
    if (!RegexConstant.isYouTubeLink(videoUrl)) {
      return videoUrl;
    }

    try {
      final youtube = YoutubeExplode();
      final manifest = await youtube.videos.streamsClient.getManifest(VideoId(videoUrl));
      final sortedStreams = manifest.muxed.toList()
        ..sort((a, b) => b.videoResolution.compareTo(a.videoResolution));
      // Select the highest quality video stream
      final streamInfo = sortedStreams.first;
      final url = streamInfo.url;

      youtube.close();

      return url.toString();
    } catch (_) {}

    return videoUrl;
  }
}
