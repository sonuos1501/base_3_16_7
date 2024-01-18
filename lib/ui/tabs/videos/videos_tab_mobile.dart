import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/channels/argument_videos_by_channel_data.dart';
import 'package:theshowplayer/models/video_detail_model/video_detail_model.dart';
import 'package:theshowplayer/ui/tabs/videos/bloc/video_tab_bloc.dart';
import 'package:theshowplayer/widgets/components/video_items.dart';
import 'package:theshowplayer/widgets/empty_box/empty_box.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';



class VideosTabMobile extends StatefulWidget {
  const VideosTabMobile({ super.key, required this.channelId });

  final int channelId;

  @override
  State<VideosTabMobile> createState() => _VideosTabMobileState();
}

class _VideosTabMobileState extends State<VideosTabMobile> {

  late final _controller = BlocProvider.of<VideoTabBloc>(context, listen: false);

  final int _offset = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.add(
        VideoTabEvent.loaded(argumentsVideosByChannelData: ArgumentsVideosByChannelData(
          channelId: widget.channelId,
          offset: _offset,
        ),),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoTabBloc, VideoTabState>(
      buildWhen: (previous, current) => current is VideoTabInitialState && current != previous,
      builder: (context, state) {
        final listVideosByChannel = <VideoDetailModel>[];
        if (state is VideoTabInitialState) {
          listVideosByChannel.addAll(state.listVideosByChannelData ?? []);
        }

        return listVideosByChannel.isEmpty
          ? Center(
            child: SingleChildScrollView(
              child: BlocBuilder<VideoTabBloc, VideoTabState>(
                builder: (context, state) {
                  if (state is VideoTabLoadingState) {
                    return const LoadingView();
                  }

                  return const EmptyBox(title: '');
                },
              ),
            ),
          )
          : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listVideosByChannel.length,
            itemBuilder: (context, index) {
              final videosByChannelData = listVideosByChannel[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
                child: VideoItems(
                  imageBackground: videosByChannelData.thumbnail ?? '',
                  avatar: videosByChannelData.owner?.avatar ?? '',
                  name: videosByChannelData.owner?.name ?? '',
                  time: videosByChannelData.duration ?? '00:00:00',
                  title: videosByChannelData.title ?? '',
                  onPressSettings: () async {},
                  onPress: () async {},
                  numberView: videosByChannelData.views ?? 0,
                  // isPremium: true,
                  // listTypeStatusItems: const [TypeStatusItems.sale],
                  // money: 26.99,
                  // numberSolds: 6,
                  // saleMoney: 16.99,
                ),
              );
            },
          );
        },
    );
  }
}
