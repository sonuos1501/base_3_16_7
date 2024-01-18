

// ignore_for_file: parameter_assignments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/enum/filter_by_datetime.dart';
import 'package:theshowplayer/constants/enum/filter_by_properties.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/models/channels/response_get_top_channels.dart';
import 'package:theshowplayer/ui/channel/bloc/channel_bloc.dart';
import 'package:theshowplayer/ui/channel/components/items_list_channels.dart';
import 'package:theshowplayer/ui/channel/components/top_channel.dart';
import 'package:theshowplayer/ui/details_channel/detail_channel_screen.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/utils.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';
import 'package:theshowplayer/widgets/empty_box/empty_box.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';
import '../../widgets/dropdown/select_drop_list.dart';

class ChannelScreenMobile extends StatefulWidget {
  const ChannelScreenMobile({super.key});

  @override
  State<ChannelScreenMobile> createState() => _ChannelScreenMobileState();
}

class _ChannelScreenMobileState extends State<ChannelScreenMobile> {

  late final _controller = BlocProvider.of<ChannelBloc>(context, listen: false);

  var _selectedFilterByProperties = FilterByProperties.views;
  var _selectedFilterByDatetime = FilterByDatetime.allTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        final channels = <Channels>[];
        if (state is ChannelInitialState) {
          channels.addAll(state.listChannels ?? []);
        }

        return Scaffold(
          backgroundColor: channels.length <= 3 ? Theme.of(context).colorScheme.surface : null,
          body: Stack(
            children: [
              _buildBody(context, channels),
              if (state is ChannelLoadingState) const Center(child: LoadingView()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, List<Channels> channels) {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.add(
          ChannelEvent.loaded(
            argumentGetTopChannels: ArgumentGetTopChannels(
              type: _selectedFilterByProperties.key,
              sortType: _selectedFilterByDatetime.key,
            ),
          ),
        );
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: Dimens.dimens_50),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildTopChannels(context, channels),
            if (channels.length > 3)
              ..._buildListChannels(channels)
            else
              Container(
                color: Theme.of(context).colorScheme.surface,
                height: ScreenUtil().setHeight(Dimens.dimens_180),
              ),
            // if (channels.isNotEmpty) Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.dimens_15),
            //   child: AddMoreItem(onPress: () async {}),
            // ),
            // if (channels.isNotEmpty) _buildChannelsYouMightLike(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListChannels(List<Channels> channels) {
    channels = channels.sublist(3);

    return List.generate(
      channels.length,
      (index) {
        final channel = channels[index];

        return ItemListChannels(
          index: index + 4,
          avatar: channel.userData?.avatar ?? '',
          onPress: () async => _handleLogicNavigateToDetailChannel(channel),
          onPressSettings: () async {},
          namePersonChannel: channel.userData?.name ?? '',
          numFollowers: (channel.subscribersCount ?? 0).toString(),
          numViews: (channel.views ?? 0).toString(),
          useDivider: index != channels.length - 1,
        );
      }
    );
  }

  Future<void> _handleLogicNavigateToDetailChannel(Channels channels) async {
    await navigation.navigateTo(RouterName.detailChannel, arguments: ArgumentsOfDetailChannelScreen(channels: channels));
  }

  Widget _buildTopChannels(BuildContext context, List<Channels> channels) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
                _titleTopChannels(context),
                Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
                _filterForChannels(),
                Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
                channels.isEmpty
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.dimens_15),
                      child: EmptyBox(title: 'channel_mg11'.tr(context)),
                    ),
                  )
                  : _topChannels(channels),
              ],
            ),
          ),
          if (channels.isNotEmpty) _divider(context),
        ],
      ),
    );
  }

  Widget _filterForChannels() {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ChannelBloc, ChannelState>(
            buildWhen: (previous, current) => current is ChannelInitialState && current != previous,
            builder: (context, state) {
              final listFilterByProperties = <FilterByProperties>[];
              if (state is ChannelInitialState) {
                listFilterByProperties.addAll(state.listFilterByProperties ?? []);
              }

              return BlocBuilder<ChannelBloc, ChannelState>(
                buildWhen: (previous, current) => current is ChannelFilterByPropertyState && current != previous,
                builder: (context, state) {
                  if (state is ChannelFilterByPropertyState) {
                    _selectedFilterByProperties = state.filterByProperty;
                  }

                  return SelectDropList(
                    content: _selectedFilterByProperties.name.tr(context),
                    hintText: '',
                    usingSearch: false,
                    listItem: listFilterByProperties.map((e) {
                      return DropdownItem(content: e.name.tr(context));
                    }).toList(),
                    onChange: (index) {
                      _controller
                        ..add(ChannelEvent.choosedFilterByProperty(filterByProperty: listFilterByProperties[index]))
                        ..add(ChannelEvent.loaded(
                          argumentGetTopChannels: ArgumentGetTopChannels(
                            type: listFilterByProperties[index].key,
                            sortType: _selectedFilterByDatetime.key,
                          ),
                        ),);
                    },
                  );
                },
              );
            },
          ),
        ),
        Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
        Expanded(
          child: BlocBuilder<ChannelBloc, ChannelState>(
            buildWhen: (previous, current) => current is ChannelInitialState && current != previous,
            builder: (context, state) {
              final listFilterByDatetime = <FilterByDatetime>[];
              if (state is ChannelInitialState) {
                listFilterByDatetime.addAll(state.listFilterByDatetime ?? []);
              }

              return BlocBuilder<ChannelBloc, ChannelState>(
                buildWhen: (previous, current) => current is ChannelFilterByDatetimeState && current != previous,
                builder: (context, state) {
                  if (state is ChannelFilterByDatetimeState) {
                    _selectedFilterByDatetime = state.filterByDatetime;
                  }

                  return SelectDropList(
                    content: _selectedFilterByDatetime.name.tr(context),
                    hintText: '',
                    usingSearch: false,
                    listItem: listFilterByDatetime.map((e) {
                      return DropdownItem(content: e.name.tr(context));
                    }).toList(),
                    onChange: (index) {
                      _controller
                        ..add(ChannelEvent.choosedFilterByDatetime(filterByDatetime: listFilterByDatetime[index]))
                        ..add(
                          ChannelEvent.loaded(
                            argumentGetTopChannels: ArgumentGetTopChannels(
                              type: _selectedFilterByProperties.key,
                              sortType: listFilterByDatetime[index].key,
                            ),
                          ),
                        );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _topChannels(List<Channels> channels) {
    const start = 0;
    const end = 3;
    if (channels.length > end) {
      channels = channels.sublist(start, end);
    }

    var topChannels = List.generate(
      channels.length,
      (index) {
        final channel = channels[index];

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < channels.length - 1 ? ScreenUtil().setHeight(Dimens.dimens_10) : 0),
            child: TopChannels(
              topNumber: index + 1,
              avatar: channel.userData?.avatar ?? '',
              name: channel.userData?.name ?? '',
              views: channel.views.toString(),
              followers: channel.subscribersCount.toString(),
              onPress: () async => _handleLogicNavigateToDetailChannel(channel),
            ),
          ),
        );
      },
    );

    if (topChannels.length > 2) {
      topChannels = Utils.switchPositions(topChannels, 0, 1);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: topChannels,
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

  Text _titleTopChannels(BuildContext context) {
    return Text(
      'channel_mg0'.tr(context),
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  // Widget _buildChannelsYouMightLike(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: ScreenUtil().setHeight(Dimens.dimens_16)),
  //         child: _titleChannels(context, onPressViewAll: _handleLogicViewAll),
  //       ),
  //       _buildListChannelsMightLike(),
  //       Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
  //         child: _divider(context),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildListChannelsMightLike() {
  //   final channelsMightLike = SizedBox(
  //     height: ScreenUtil().setWidth(Dimens.dimens_160),
  //     child: ListView.builder(
  //       itemCount: 10,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
  //           child: LiveAndChannelItems(
  //             imageBackground: 'https://images.lifestyleasia.com/wp-content/uploads/sites/5/2022/08/01134813/BLACKPINK-1-1600x898.jpeg',
  //             avatar: 'https://image.baophapluat.vn/1200x630/Uploaded/2023/gznrxgmabianhgzmath/2021_07_16/blackpink-rose5-4847.jpg',
  //             name: 'Rose',
  //             onPress: _handleLogicChooseChannel,
  //             size: Size(ScreenUtil().setWidth(Dimens.dimens_200), ScreenUtil().setWidth(Dimens.dimens_132)),
  //             listTypeStatusItems: const [TypeStatusItems.hot],
  //             infoLivesChannels: const InfoLivesChannels(numVideos: '30', numViews: '20k'),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   return channelsMightLike;
  // }

  // Future<void> _handleLogicChooseChannel() async {}

  // Future<void> _handleLogicViewAll() async {}

  // Widget _titleChannels(BuildContext context, { required AsyncCallback onPressViewAll }) {
  //   final title = Text(
  //     'channel_mg1'.tr(context),
  //     style: Theme.of(context).textTheme.labelLarge!.copyWith(
  //       fontWeight: AppThemeData.medium,
  //       color: Theme.of(context).colorScheme.surfaceVariant,
  //     ),
  //   );
  //   final viewAll = Text(
  //     'channel_mg2'.tr(context),
  //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //       fontWeight: AppThemeData.regular,
  //       color: Theme.of(context).colorScheme.onInverseSurface,
  //     ),
  //   );
  //   return Row(
  //     children: [
  //       Expanded(child: title),
  //       Gap(ScreenUtil().setWidth(Dimens.dimens_05)),
  //       viewAll,
  //     ],
  //   );
  // }

}
