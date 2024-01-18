
// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';

class ShortItems extends StatelessWidget {
  const ShortItems({
    super.key,
    required this.imageBackground,
    required this.title,
    required this.onPress,
    required this.numberView,
    required this.size,
    this.gradient,
  });

  final String title, imageBackground;
  final AsyncCallback onPress;
  final String numberView;
  final Size size;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Stack(
        children: [
          CacheImage(
            image: imageBackground,
            size: size,
          ),
          Container(
            height: size.height,
            width: size.width,
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
          Positioned.fill(left: Dimens.dimens_12, bottom: Dimens.dimens_12, child: Align(alignment: Alignment.bottomLeft, child: _buildInfoVideo(context))),
        ],
      ),
    );
  }

  Widget _buildInfoVideo(BuildContext context) {
    return SizedBox(
      width: size.width - Dimens.dimens_12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleShort(context),
          const Gap(Dimens.dimens_02),
          _buildNumViewsShort(context),
        ],
      ),
    );
  }

  Text _buildNumViewsShort(BuildContext context) {
    return Text(
      '$numberView ${'views'.tr(context)}',
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildTitleShort(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.semiBold,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

}
