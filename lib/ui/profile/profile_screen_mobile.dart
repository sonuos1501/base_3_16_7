
// ignore_for_file: avoid_multiple_declarations_per_line


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/blocs/common_blocs/authentication/authentication_bloc.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view_not_logo.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../models/channels/channel_info_data.dart';
import '../../utils/utils.dart';


class ProfileScreenMobile extends StatelessWidget {
  const ProfileScreenMobile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
            const BackIconAppbar(),
            Expanded(child: _buildBody(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
            _termOfUserAndPrivacyPolicy(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          ],
        ),
      ),
    );
  }

  Widget _termOfUserAndPrivacyPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildTitlePolicy(context, title: 'login_mg7', textAlign: TextAlign.right, onPress: _handleLogiNavigateToTermsOfUse)),
          Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
          SvgPicture.asset(Assets.icDot),
          Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
          Expanded(child: _buildTitlePolicy(context, title: 'login_mg8', onPress: _handleLogiNavigateToPrivacyPolicy)),
        ],
      ),
    );
  }

  Future<void> _handleLogiNavigateToTermsOfUse() async {
  }

  Future<void> _handleLogiNavigateToPrivacyPolicy() async {
  }

  Widget _buildTitlePolicy(BuildContext context, {
    required String title,
    TextAlign textAlign = TextAlign.left,
    required AsyncCallback onPress,
  }) {
    return CommonButton(
      onPress: onPress,
      child: Text(
        title.tr(context),
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          fontWeight: AppThemeData.medium,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(ScreenUtil().setHeight(Dimens.dimens_25)),
            _buildInformation(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
            _buildOptionsFunction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsFunction(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOption(context, icon: Assets.icNoti, title: 'profile_mg1', onPress: _handleLogicOptionNotification),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icWallet, title: 'profile_mg2', onPress: _handleLogicOptionWallet),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icPlayList, title: 'profile_mg3', onPress: _handleLogicOptionPlaylist),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icHistory, title: 'profile_mg4', onPress: _handleLogicOptionHistory),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icLock, title: 'profile_mg5', onPress: _handleLogicOptionRentedVideos),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icQuestion, title: 'profile_mg6', onPress: _handleLogicOptionHelps),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        _buildOption(context, icon: Assets.icSettings, title: 'profile_mg7', onPress: _handleLogicOptionSettings),
        Gap(ScreenUtil().setHeight(Dimens.dimens_28)),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: LoadingProcessBuilder.showProgressDialog,
              fail: (errors) async {
                Utils.showToast(context, errors ?? 'Error', status: false);
                await LoadingProcessBuilder.closeProgressDialog();
              },
              authenticated: (_, __, ___, ____) async {
                await LoadingProcessBuilder.closeProgressDialog();
              },
              unAuthenticated: (_) async {
                Utils.showToast(context, 'Logout successful');
                await LoadingProcessBuilder.closeProgressDialog();
                await navigation.navigatePushAndRemoveUntil(RouterName.dashboard);
              },
            );
          },
          child: _buildOption(context, icon: Assets.icLogout, title: 'profile_mg22', onPress: _handleLogicOptionLogout),
        ),
      ],
    );
  }

  Future<void> _handleLogicOptionNotification() async => navigation.navigateTo(RouterName.notifications);

  Future<void> _handleLogicOptionWallet() async {}

  Future<void> _handleLogicOptionPlaylist() async => navigation.navigateTo(RouterName.playlist);

  Future<void> _handleLogicOptionHistory() async => navigation.navigateTo(RouterName.history);

  Future<void> _handleLogicOptionRentedVideos() async => navigation.navigateTo(RouterName.rentedVideos);

  Future<void> _handleLogicOptionHelps() async => navigation.navigateTo(RouterName.help);

  Future<void> _handleLogicOptionSettings() async => navigation.navigateTo(RouterName.settings);

  Future<void> _handleLogicOptionLogout() async {
    sl<AuthenticationBloc>().add(const AuthenticationEvent.logout());
  }

  Widget _buildOption(
    BuildContext context, {
    required String icon,
    required String title,
    required AsyncCallback onPress,
  }) {
    return CommonButton(
      onPress: onPress,
      child: Row(
        children: [
          _iconOption(context, icon),
          Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
          Expanded(child: _titleOption(context, title)),
        ],
      ),
    );
  }

  Widget _iconOption(BuildContext context, String icon) {
    const size = Dimens.dimens_20;
    return SvgPicture.asset(icon, width: size, color: Theme.of(context).colorScheme.surfaceVariant);
  }

  Text _titleOption(BuildContext context, String title) {
    return Text(
      title.tr(context),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.regular,
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => current is Authenticated && current != previous,
      builder: (context, state) {
        var channelInfo = ChannelInfoData();
        if (state is Authenticated) {
          channelInfo = state.channelInfoData ?? ChannelInfoData();
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAvatar(context, channelInfo),
            Gap(ScreenUtil().setWidth(Dimens.dimens_15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildFullName(context, channelInfo),
                  Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
                  _buildSubName(context, channelInfo),
                  Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
                  _buildEditProfile(context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditProfile(BuildContext context) {
    return CommonButton(
      onPress: _handleLogicNavigateToEditProfile,
      child: Text(
        'profile_mg0'.tr(context),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.outline,
          fontWeight: AppThemeData.regular,
        ),
      ),
    );
  }

  Future<void> _handleLogicNavigateToEditProfile() async {
    await navigation.navigateTo(RouterName.editProfile);
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
    final avatarImg = channelInfo.avatar ?? '';

    return CacheImage(
      image: avatarImg,
      size: Size(size, size),
      borderRadius: size / 2,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

}
