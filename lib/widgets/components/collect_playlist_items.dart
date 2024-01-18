
// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';

class CollectPlaylistItems extends StatelessWidget {
  const CollectPlaylistItems({
    super.key,
    required this.imageBackground,
    required this.title,
    required this.onPress,
    this.numberItems,
    this.gradient,
    this.height = Dimens.dimens_100,
  });

  final String title, imageBackground;
  final AsyncCallback onPress;
  final int? numberItems;
  final LinearGradient? gradient;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Positioned(right: Dimens.dimens_05, bottom: Dimens.dimens_05, child: _buildNumPlaylist(context)),
              ],
            ),
          ),
          const Gap(Dimens.dimens_10),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildTitlePlaylist(context),
              Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
              _buildViewAllPlaylist(context),
            ],
          ),),
        ],
      ),
    );
  }

  Text _buildTitlePlaylist(BuildContext context) {
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

  Text _buildViewAllPlaylist(BuildContext context) {
    return Text(
      'channel_mg12'.tr(context),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
    );
  }

  Widget _buildNumPlaylist(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_10, vertical: Dimens.dimens_05),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(Dimens.dimens_0_6),
        borderRadius: BorderRadius.circular(Dimens.dimens_06),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icPlaylistNum),
          const Gap(Dimens.dimens_03),
          Text(
            (numberItems ?? 0).toString(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

}
