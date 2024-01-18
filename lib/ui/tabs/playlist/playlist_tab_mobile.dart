import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/models/channels/get_my_playlists_data.dart';
import 'package:theshowplayer/ui/tabs/playlist/bloc/playlist_tab_bloc.dart';
import 'package:theshowplayer/widgets/components/collect_playlist_items.dart';

import '../../../constants/dimens.dart';
import '../../../widgets/empty_box/empty_box.dart';
import '../../../widgets/loading/loading_view.dart';


class PlaylistTabMobile extends StatefulWidget {
  const PlaylistTabMobile({super.key, required this.channelId });

  final int channelId;

  @override
  State<PlaylistTabMobile> createState() => _PlaylistTabMobileState();
}

class _PlaylistTabMobileState extends State<PlaylistTabMobile> {
  late final _controller = BlocProvider.of<PlaylistTabBloc>(context, listen: false);

  final int _limit = 100;
  final int _offset = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.add(
        PlaylistTabEvent.loaded(argumentMyPlaylistsData: ArgumentMyPlaylistsData(
          channelId: widget.channelId,
          limit: _limit,
          offset: _offset,
        ),),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistTabBloc, PlaylistTabState>(
      buildWhen: (previous, current) => current is PlaylistTabInitialState && current != previous,
      builder: (context, state) {
        final listMyPlaylist = <MyPlaylistsData>[];
        if (state is PlaylistTabInitialState) {
          listMyPlaylist.addAll(state.listMyPlaylists ?? []);
        }

        return listMyPlaylist.isEmpty
          ? Center(
            child: SingleChildScrollView(
              child: BlocBuilder<PlaylistTabBloc, PlaylistTabState>(
                builder: (context, state) {
                  if (state is PlaylistTabLoadingState) {
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
            itemCount: listMyPlaylist.length,
            itemBuilder: (context, index) {
              final playlist = listMyPlaylist[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
                child: CollectPlaylistItems(
                  imageBackground: playlist.thumbnail ?? '',
                  title: playlist.name ?? '',
                  onPress: () async {},
                  numberItems: playlist.count,
                ),
              );
            },
          );
      },
    );
  }
}
