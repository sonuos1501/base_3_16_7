// ignore_for_file: inference_failure_on_function_invocation


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view_not_logo.dart';
import 'package:theshowplayer/widgets/bottom_sheet/item_bottomsheet_have_icon.dart';
import 'package:theshowplayer/widgets/text/rich_text_link.dart';

import '../../constants/app_theme.dart';
import '../../constants/assets.dart';
import '../../constants/dimens.dart';
import '../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../../widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import '../../widgets/button/contained_button.dart';
import '../../widgets/components/tab_view.dart';
import '../../widgets/image/cache_image.dart';
import '../tabs/like_videos/like_videos_tab.dart';
import '../tabs/playlist/playlist_tab.dart';
import '../tabs/shorts/shorts_tab.dart';
import '../tabs/videos/videos_tab.dart';
import 'bloc/detail_channel_bloc.dart';
import 'detail_channel_screen.dart';

class DetailChannelScreenMobile extends StatelessWidget {
  const DetailChannelScreenMobile({ super.key, required this.argumentsOfDetailChannelScreen });

  final ArgumentsOfDetailChannelScreen argumentsOfDetailChannelScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: argumentsOfDetailChannelScreen.channels.userData?.name ?? '',
        actions: [
          ButtonIconAction(icon: Assets.icSearch, onTab: _handleLogicNavigateToSearch),
          ButtonIconAction(icon: Assets.icMenuSettings, onTab: () => _handleLogicNavigateToMenuSettings(context)),
        ],
      ),
      body: SafeArea(
        child: _tabView(context),
      ),
    );
  }

  Column _buildHeader(BuildContext context) {
    return Column(
      children: [
        _buildPersonalCoverPhoto(),
        Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
        _buildInfoPersonal(context),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
      ],
    );
  }

  Widget _tabView(BuildContext context) {
    return TabView(
      header: _buildHeader(context),
      titles: ['videos'.tr(context), 'profile_mg3'.tr(context), '${'short'.tr(context)}s', 'like_videos'.tr(context)],
      bodies: [
        VideosTab(channelId: argumentsOfDetailChannelScreen.channels.userData?.id ?? -1),
        PlaylistTab(channelId: argumentsOfDetailChannelScreen.channels.userData?.id ?? -1),
        ShortsTab(channelId: argumentsOfDetailChannelScreen.channels.userData?.id ?? -1),
        LikeVideosTab(channelId: argumentsOfDetailChannelScreen.channels.userData?.id ?? -1),
      ],
    );
  }

  Widget _buildInfoPersonal(BuildContext context) {
    final infomationPerson = Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: Column(
        children: [
          _avatar(context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _name(context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _highLightsInformation(context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _introduce(context),
          _buildButtonSubcribeAndUnsubcribe(context),
        ],
      ),
    );
    return infomationPerson;
  }

  Widget _buildButtonSubcribeAndUnsubcribe(BuildContext context) {
    return BlocBuilder<DetailChannelBloc, DetailChannelState>(
      buildWhen: (previous, current) => current is DetailChannelSubcribeAndUnsubcribeState && current != previous,
      builder: (context, state) {
        var isSubcribe = false;
        if (state is DetailChannelSubcribeAndUnsubcribeState) {
          isSubcribe = state.isSubcribe;
        }

        return ContainedButton(
          title: isSubcribe ? 'unsubscribe'.tr(context) : 'subcribe'.tr(context),
          size: const Size(double.infinity, Dimens.dimens_44),
          colorTitle: isSubcribe ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceVariant,
          color: isSubcribe ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.onSecondaryContainer,
          onPress: () => _handleLogicOnPressSubcribeAndUnsubcribe(context, isSubcribe),
        );
      },
    );
  }

  Future<void> _handleLogicOnPressSubcribeAndUnsubcribe(BuildContext context, bool isSubcribe) async {
    BlocProvider.of<DetailChannelBloc>(context, listen: false).add(DetailChannelEvent.subcribed(subcribed: !isSubcribe));
  }

  Widget _introduce(BuildContext context) {
    final intro = BlocBuilder<DetailChannelBloc, DetailChannelState>(
      buildWhen: (previous, current) => current is DetailChannelMoreIntroduceState && current != previous,
      builder: (context, state) {
        var isMore = false;
        if (state is DetailChannelMoreIntroduceState) {
          isMore = state.isMore;
        }

        final about = argumentsOfDetailChannelScreen.channels.userData?.about ?? '';

        return about.isNotEmpty ? Padding(
          padding: const EdgeInsets.only(bottom: Dimens.dimens_16),
          child: RichTextWidget(
            textAlign: TextAlign.start,
            texts: [
              BaseText.plain(
                text: '$about ',
                maxLines: isMore ? null : 3,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: AppThemeData.regular,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              BaseText.link(
                text: isMore ? 'less'.tr(context) : 'more'.tr(context),
                onTapped: () => _handleLogicMoreIntro(context, isMore),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: AppThemeData.regular,
                ),
              ),
            ],
          ),
        ) : const SizedBox.shrink();
      },
    );
    return intro;
  }

  void _handleLogicMoreIntro(BuildContext context, bool isMore) => BlocProvider.of<DetailChannelBloc>(context, listen: false)..add(DetailChannelEvent.moredIntro(moredIntro: !isMore));

  Widget _highLightsInformation(BuildContext context) {
    final highLights = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _views(context),
        const Gap(Dimens.dimens_15),
        _followers(context),
      ],
    );

    return highLights;
  }

  Widget _followers(BuildContext context) {
    return _titleIntroduce(
      context,
      icon: Assets.icPlus,
      title: '${argumentsOfDetailChannelScreen.channels.subscribersCount ?? 0} ${'subcribe'.tr(context).toLowerCase()}s',
    );
  }

  Widget _views(BuildContext context) {
    return _titleIntroduce(
      context,
      icon: Assets.icEge,
      title: '${argumentsOfDetailChannelScreen.channels.views ?? 0} ${'views'.tr(context)}',
    );
  }

  Widget _titleIntroduce(BuildContext context, {required String icon, required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, height: Dimens.dimens_15),
        Gap(ScreenUtil().setWidth(Dimens.dimens_03)),
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Text _name(BuildContext context) {
    return Text(
      argumentsOfDetailChannelScreen.channels.userData?.name ?? '',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    final size = ScreenUtil().setWidth(Dimens.dimens_80);

    return CacheImage(
      image: argumentsOfDetailChannelScreen.channels.userData?.avatar ?? '',
      size: Size(size, size),
      borderRadius: size / 2,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Widget _buildPersonalCoverPhoto() {
    final image = CacheImage(
      image: argumentsOfDetailChannelScreen.channels.userData?.fullCover ?? '',
      size: Size(double.infinity, ScreenUtil().setHeight(Dimens.dimens_100)),
      borderRadius: 0,
    );

    return image;
  }

  Future<void> _handleLogicNavigateToMenuSettings(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          ItemBottomSheetHaveIcon(icon: Assets.icShare, title: 'share'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icBlock, title: 'block_user'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icReportUser, title: 'report_user'.tr(context), useDivider: false, onPress: () {}),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}
}
