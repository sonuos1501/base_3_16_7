import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../models/channels/channel_info_data.dart';

enum AppbarShowType { showBackButton, showWidget, showBackDefault }

class AppbarView extends StatelessWidget implements PreferredSizeWidget {
  const AppbarView({
    super.key,
    this.title,
    this.height = Dimens.dimens_100,
    this.paddingRight = Dimens.dimens_16,
    this.onSearchTap,
    this.onMessTap,
  });
  final String? title;
  final double? height;
  final double paddingRight;
  final void Function()? onSearchTap;
  final void Function()? onMessTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        var channelInfo = ChannelInfoData();
        if (state is Authenticated) {
          channelInfo = state.channelInfoData ?? ChannelInfoData();
        }

        return Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: paddingRight,
          ).copyWith(bottom: 13),
          color: Theme.of(context).colorScheme.surface,
          width: double.infinity,
          height: height,
          child: Row(
            children: [
              CommonButton(
                onPress: () async {
                  await navigation.navigatePushAndRemoveUntil(RouterName.dashboard);
                },
                child: SvgPicture.asset(
                  Assets.icLogoAppBar,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onSearchTap,
                child: SvgPicture.asset(
                  Assets.icSearch,
                  fit: BoxFit.cover,
                ),
              ),
              if (state is Authenticated) ...[
                Gap(ScreenUtil().setWidth(Dimens.dimens_16)),
                InkWell(
                  onTap: onMessTap,
                  child: SvgPicture.asset(
                    Assets.icMessage,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Gap(ScreenUtil().setWidth(Dimens.dimens_16)),
              InkWell(
                onTap: () {
                  if (state is Authenticated) {
                    navigation.navigateTo(RouterName.profile);
                  } else {
                    navigation.navigateTo(RouterName.login);
                  }
                },
                child: CacheImage(
                  image: channelInfo.avatar ?? '',
                  size: const Size(28, 28),
                  borderRadius: 14,
                  errorLoadingImage: Assets.icAvatarDefault,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? Dimens.dimens_50);
}
