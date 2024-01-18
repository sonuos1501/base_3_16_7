
// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../constants/assets.dart';
import '../../constants/dimens.dart';

class PlaylistItems extends StatelessWidget {
  const PlaylistItems({
    super.key,
    required this.imageBackground,
    required this.avatar,
    required this.name,
    required this.time,
    required this.title,
    required this.onPress,
    this.numberView,
    this.gradient,
    this.height = Dimens.dimens_120,
  });

  final String title, imageBackground, avatar, name;
  final String time;
  final AsyncCallback onPress;
  final int? numberView;
  final LinearGradient? gradient;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                CacheImage(
                  image: imageBackground,
                  size: Size(double.infinity, ScreenUtil().setWidth(height)),
                ),
                Container(
                  height: ScreenUtil().setWidth(height),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.dimens_08),
                    gradient: gradient ?? LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0, 0.12, 0.82],
                      colors: [
                        AppColors.black1D1313.withOpacity(0.9),
                        AppColors.black1B1313.withOpacity(0.78),
                        AppColors.black121212.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Positioned(right: Dimens.dimens_05, bottom: Dimens.dimens_05, child: _buildTimeVideo(context)),
              ],
            ),
          ),
          const Gap(Dimens.dimens_10),
          Expanded(child: Column(
            children: [
              _buildTitleVideo(context),
              Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
              _buildInfoPerson(context),
            ],
          ),),
        ],
      ),
    );
  }

  Widget _buildInfoPerson(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(),
        const Gap(Dimens.dimens_05),
        Expanded(child: Row(
          children: [
            Flexible(child: _buildTitleInfo(context, name)),
            const Gap(Dimens.dimens_05),
            SvgPicture.asset(Assets.icDot),
            const Gap(Dimens.dimens_05),
            Flexible(child: _buildTitleInfo(context, '${numberView ?? 0} ${'views'.tr(context)}')),
          ],
        ),),
      ],
    );
  }

  CacheImage _buildAvatar() {
    return CacheImage(
      image: avatar,
      size: const Size(28, 28),
      borderRadius: 14,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Text _buildTitleInfo(BuildContext context, String titleInfo) {
    return Text(
      titleInfo,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    );
  }

  Text _buildTitleVideo(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Widget _buildTimeVideo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_10, vertical: Dimens.dimens_05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(Dimens.dimens_0_6),
        borderRadius: BorderRadius.circular(Dimens.dimens_06),
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: AppThemeData.regular,
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ),
    );
  }

}
