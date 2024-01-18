import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/models/channels/argument_like_videos_by_channel.dart';
import 'package:theshowplayer/ui/tabs/like_videos/bloc/like_video_tab_bloc.dart';

import '../../../constants/dimens.dart';
import '../../../models/video_detail_model/video_detail_model.dart';
import '../../../widgets/components/video_items.dart';
import '../../../widgets/empty_box/empty_box.dart';
import '../../../widgets/loading/loading_view.dart';


class LikeVideosTabMobile extends StatefulWidget {
  const LikeVideosTabMobile({ super.key, required this.channelId });

  final int channelId;

  @override
  State<LikeVideosTabMobile> createState() => _LikeVideosTabMobileState();
}

class _LikeVideosTabMobileState extends State<LikeVideosTabMobile> {

  late final _controller = BlocProvider.of<LikeVideoTabBloc>(context, listen: false);

  final int _offset = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.add(
        LikeVideoTabEvent.loadedLikeVideos(argumentsLikeVideosByChannelData: ArgumentsLikeVideosByChannelData(
          channelId: widget.channelId,
          offset: _offset,
        ),),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeVideoTabBloc, LikeVideoTabState>(
      buildWhen: (previous, current) => current is LikeVideoTablistLikeVideosByChannelDataState && current != previous,
      builder: (context, state) {
        final listLikeVideosByChannel = <VideoDetailModel>[];
        if (state is LikeVideoTablistLikeVideosByChannelDataState) {
          listLikeVideosByChannel.addAll(state.listVideosByChannelData);
        }

        return listLikeVideosByChannel.isEmpty
          ?  Center(
            child: SingleChildScrollView(
              child: BlocBuilder<LikeVideoTabBloc, LikeVideoTabState>(
                builder: (context, state) {
                  if (state is LikeVideoTabLoadingState) {
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
            itemCount: listLikeVideosByChannel.length,
            itemBuilder: (context, index) {
              final likeVideosByChannelData = listLikeVideosByChannel[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
                child: VideoItems(
                  imageBackground: likeVideosByChannelData.thumbnail ?? '',
                  avatar: likeVideosByChannelData.owner?.avatar ?? '',
                  name: likeVideosByChannelData.owner?.name ?? '',
                  time: likeVideosByChannelData.duration ?? '00:00:00',
                  title: likeVideosByChannelData.title ?? '',
                  onPressSettings: () async {},
                  onPress: () async {},
                  numberView: likeVideosByChannelData.views ?? 0,
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
