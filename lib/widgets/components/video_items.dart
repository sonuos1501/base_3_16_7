// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/button/cs_icon_button.dart';
import 'package:theshowplayer/widgets/components/tags_status.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../constants/assets.dart';
import '../../constants/dimens.dart';
import '../../constants/enum/type_status_items.dart';

class VideoItems extends StatelessWidget {
  const VideoItems({
    super.key,
    required this.imageBackground,
    required this.avatar,
    required this.name,
    required this.time,
    required this.title,
    required this.onPressSettings,
    required this.onPress,
    this.numberView,
    this.gradient,

    /// Premium
    this.isPremium = false,
    this.money,
    this.saleMoney,
    this.listTypeStatusItems,
    this.numberSolds,
    this.pathVideo,
  });

  final String title, imageBackground, avatar, name;
  final String time;
  final AsyncCallback onPressSettings, onPress;
  final int? numberView;
  final LinearGradient? gradient;

  /// Premium
  final bool isPremium;
  final double? money, saleMoney;
  final List<TypeStatusItems>? listTypeStatusItems;
  final int? numberSolds;
  final String? pathVideo;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CacheImage(
                image: imageBackground,
                size: Size(
                    double.infinity, ScreenUtil().setHeight(Dimens.dimens_190),),
              ),
              Container(
                height: ScreenUtil().setHeight(Dimens.dimens_190),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.dimens_08),
                  gradient: gradient ??
                      LinearGradient(
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
              Positioned.fill(
                  left: Dimens.dimens_12,
                  bottom: Dimens.dimens_12,
                  child: Align(alignment: Alignment.bottomLeft,child: _buildInfoVideo(context)),),
              if (isPremium)
                Positioned(
                  top: Dimens.dimens_12,
                  left: Dimens.dimens_12,
                  child: SvgPicture.asset(Assets.icPremium),
                ),
              if (isPremium)
                Positioned(
                  top: Dimens.dimens_12,
                  right: Dimens.dimens_03,
                  child: _buildTagsStatus(context),
                ),
            ],
          ),
          const Gap(Dimens.dimens_12),
          _buildInfoPerson(context),
        ],
      ),
    );
  }

  Widget _buildTagsStatus(BuildContext context) {
    final tags = listTypeStatusItems ?? [];
    return Row(
      children: [
        ...List.generate(
          tags.length,
          (index) => Padding(
            padding: EdgeInsets.only(left: index > 0 ? Dimens.dimens_05 : 0),
            child: TagStatus(
              title: tags[index].text(context),
              backgroundColor: tags[index].color(context),
            ),
          ),
        ),
        const Gap(Dimens.dimens_10),
        _buildSettings(Theme.of(context).colorScheme.surfaceVariant),
      ],
    );
  }

  Widget _buildInfoPerson(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(),
        const Gap(Dimens.dimens_05),
        Expanded(
          child: Row(
            children: [
              Flexible(child: _buildTitleInfo(context, name)),
              const Gap(Dimens.dimens_05),
              SvgPicture.asset(Assets.icDot),
              const Gap(Dimens.dimens_05),
              Flexible(
                child: _buildTitleInfo(
                  context,
                  isPremium ? '${numberSolds ?? 0} ${'solds'.tr(context)}' : '${numberView ?? 0} ${'views'.tr(context)}',
                ),
              ),
            ],
          ),
        ),
        isPremium ? _buildPrice(context) : _buildSettings(Theme.of(context).colorScheme.onTertiaryContainer),
      ],
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (saleMoney != null) _priceIsNotOnSale(context),
        _priceOnSale(context),
      ],
    );
  }

  Text _priceOnSale(BuildContext context) {
    return Text(
      r'$' '${saleMoney ?? money ?? 0}',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: AppThemeData.medium,
            color: Theme.of(context).colorScheme.outline,
          ),
    );
  }

  Text _priceIsNotOnSale(BuildContext context) {
    return Text(
      r'$' + (money ?? 0).toString(),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }

  CsIconButton _buildSettings(Color color) {
    return CsIconButton(
      image: Assets.icMenuSettings,
      height: Dimens.dimens_20,
      padding: const EdgeInsets.only(right: Dimens.dimens_12, left: Dimens.dimens_05,),
      color: color,
      onPress: onPressSettings,
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
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    );
  }

  Widget _buildInfoVideo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimeVideo(context),
        const Gap(Dimens.dimens_02),
        _buildTitleVideo(context),
      ],
    );
  }

  Text _buildTitleVideo(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Widget _buildTimeVideo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_10, vertical: Dimens.dimens_05,),
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
