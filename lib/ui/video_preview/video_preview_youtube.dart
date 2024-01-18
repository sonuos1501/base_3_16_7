import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/video_preview/video_adapter_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePreview extends StatefulWidget {
  const YoutubePreview({super.key, required this.arguments});

  final VideoPreviewScreenArguments arguments;

  @override
  State<YoutubePreview> createState() => _YoutubePreviewState();
}

class _YoutubePreviewState extends State<YoutubePreview> {
  YoutubePlayerController? _controller;
  late YoutubePlayer _youtubePlayer;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  final bool _isPlayerReady = false;

  void _initPlayer() {
    print(widget.arguments.path);
    // --xHSbC7MRQ
    // final videoId = YoutubePlayer.convertUrlToId(
    //   // 'https://www.youtube.com/watch?v=4Jo8lhv-CzA',
    //   widget.path,
    // );

    // print(videoId);

    // _controller = YoutubePlayerController(
    //   params: const YoutubePlayerParams(
    //     showControls: true,
    //     enableCaption: false,
    //     color: 'red',
    //     mute: false,
    //     showFullscreenButton: true,
    //     showVideoAnnotations: false,
    //     loop: false,
    //   ),
    // )..loadVideo(widget.path);

    //  _idController = TextEditingController();
    // _seekToController = TextEditingController();

    _controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.arguments.path) ?? '', flags: const YoutubePlayerFlags())..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    _youtubePlayer = YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: true,
      progressColors: const ProgressBarColors(
        handleColor: Colors.red,
        playedColor: Colors.red,
        backgroundColor: Colors.blue,
      ),
      progressIndicatorColor: Colors.red,
      // topActions: [
      //   Container(
      //     width: 20,
      //     height: 20,
      //     color: Colors.red,
      //   ),
      //   const Text('data')
      // ],
      // bottomActions: [
      //   Container(
      //     width: 50,
      //     height: 50,
      //     color: Colors.red,
      //   ),
      // ],
    );
    // _controller.loadVideo(
    //     'https://www.youtube.com/watch?v=pE-62coP2dw&ab_channel=%EB%80%A8tvkkyutv');
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        _playerState = _controller!.value.playerState;
        _videoMetaData = _controller!.metadata;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height;

    // final currentOrientation = MediaQuery.of(context).orientation;
    // if (currentOrientation == Orientation.portrait) {
    //   height = 215;
    // } else {
    //   height = MediaQuery.of(context).size.height - 58;
    // }

    // return _controller != null
    //     ? YoutubePlayerScaffold(
    //         enableFullScreenOnVerticalDrag: false,
    //         autoFullScreen: false,
    //         controller: _controller!,
    //         builder: (context, player) {
    //           return SizedBox.expand(

    //             child: player,
    //           );
    //         },
    //       )
    //     : const Center(
    //         child: LoadingView(),
    //       );

    return YoutubePlayerBuilder(
      player: _youtubePlayer,
      builder: (context, player) {
        return const SizedBox();
      },
    );
  }
}
