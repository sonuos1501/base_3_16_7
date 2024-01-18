// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../widgets/button/cs_icon_button.dart';
import '../../../widgets/divider/divider.dart';
import '../../../widgets/image/cache_image.dart';

const _listColors = <Color>[
  AppColors.redD84141,
  AppColors.redF3C8C8,
  AppColors.redFF7B7B,
  AppColors.redFF5252,
  AppColors.redC8160C,
  AppColors.whiteFDFDFE,
  AppColors.purpleB141D8,
  AppColors.pinkD84193,
  AppColors.green56D841,
  AppColors.yellowECC53B,
  AppColors.blue41B4D8,
];

class ItemListChannels extends StatelessWidget {
  const ItemListChannels({
    super.key,
    required this.index,
    required this.onPress,
    required this.onPressSettings,
    required this.avatar,
    required this.namePersonChannel,
    required this.numViews,
    required this.numFollowers,
    required this.useDivider,
  });

  final int index;
  final AsyncCallback onPress, onPressSettings;
  final String avatar, namePersonChannel, numViews, numFollowers;
  final bool useDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
        child: Column(
          children: <Widget>[
            Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
            Row(
              children: <Widget>[
                _countNumber(context),
                Gap(ScreenUtil().setWidth(Dimens.dimens_15)),
                _buildAvatar(),
                Gap(ScreenUtil().setWidth(Dimens.dimens_15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildNamePersonChannel(context),
                      Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
                      _buildSubNamePersonChannel(context),
                    ],
                  ),
                ),
                _buildSettings(context),
              ],
            ),
            if (useDivider) ...[
              Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
              _divider(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubNamePersonChannel(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '$numViews ${'views'.tr(context).toLowerCase()}',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
        const Gap(Dimens.dimens_05),
        SvgPicture.asset(Assets.icDot),
        const Gap(Dimens.dimens_05),
        Flexible(
          child: Text(
            '$numFollowers ${'followers'.tr(context).toLowerCase()}',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Text _buildNamePersonChannel(BuildContext context) {
    final text = Text(
      namePersonChannel,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );

    return text;
  }

  CsIconButton _buildSettings(BuildContext context) {
    return CsIconButton(
      image: Assets.icMenuSettings,
      height: Dimens.dimens_13,
      padding: const EdgeInsets.only(right: Dimens.dimens_12, left: Dimens.dimens_05),
      color: Theme.of(context).colorScheme.onTertiaryContainer,
      onPress: onPressSettings,
    );
  }

  CacheImage _buildAvatar() {
    final size = ScreenUtil().setWidth(Dimens.dimens_50);

    return CacheImage(
      image: avatar,
      size: Size(size, size),
      borderRadius: size / 2,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Widget _countNumber(BuildContext context) {
    final size = ScreenUtil().setWidth(Dimens.dimens_35);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _listColors[index % _listColors.length].withOpacity(0.3),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Text(
        index.toString(),
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: AppThemeData.regular,
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ),
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
