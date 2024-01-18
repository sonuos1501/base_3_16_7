import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../constants/dimens.dart';
import '../../../models/channels/channel_info_data.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/components/tab_view.dart';
import '../../../widgets/divider/divider.dart';
import '../../../widgets/image/cache_image.dart';
import '../../tabs/like_videos/like_videos_tab.dart';
import '../../tabs/playlist/playlist_tab.dart';
import '../../tabs/shorts/shorts_tab.dart';


class PlayListScreenMobile extends StatelessWidget {
  const PlayListScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: 'profile_mg3'.tr(context),
        actions: [
          ButtonIconAction(icon: Assets.icSearch, onTab: _handleLogicNavigateToSearch),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) => current is Authenticated && current != previous,
          builder: (context, state) {
            var channelInfo = ChannelInfoData();
            if (state is Authenticated) {
              channelInfo = state.channelInfoData ?? ChannelInfoData();
            }

            return Column(
              children: [
                _divider(context),
                Expanded(child: _tabView(context, channelInfo)),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}

  Column _buildHeader(BuildContext context, ChannelInfoData channelInfo) {
    return Column(
      children: [
        const Gap(Dimens.dimens_30),
        _buildInformation(context, channelInfo),
        const Gap(Dimens.dimens_15),
      ],
    );
  }

  Widget _buildInformation(BuildContext context, ChannelInfoData channelInfo) {
    return Column(
      children: <Widget>[
        _buildAvatar(context, channelInfo),
        Gap(ScreenUtil().setWidth(Dimens.dimens_15)),
        _buildFullName(context, channelInfo),
        Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
        _buildSubName(context, channelInfo),
      ],
    );
  }

  Text _buildSubName(BuildContext context, ChannelInfoData channelInfo) {
    return Text(
      channelInfo.username ?? '',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        fontWeight: AppThemeData.regular,
      ),
    );
  }

  Text _buildFullName(BuildContext context, ChannelInfoData channelInfo) {
    return Text(
      channelInfo.name ?? '',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.medium,
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, ChannelInfoData channelInfo) {
    final size = ScreenUtil().setWidth(Dimens.dimens_72);

    return CacheImage(
      image: channelInfo.avatar ?? '',
      size: Size(size, size),
      borderRadius: size / 2,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Widget _tabView(BuildContext context, ChannelInfoData channelInfo) {
    return TabView(
      header: _buildHeader(context, channelInfo),
      titles: ['profile_mg3'.tr(context), '${'short'.tr(context)}s', 'like_videos'.tr(context)],
      bodies: [
        PlaylistTab(channelId: channelInfo.id ?? -1),
        ShortsTab(channelId: channelInfo.id ?? -1),
        LikeVideosTab(channelId: channelInfo.id ?? -1),
      ],
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
