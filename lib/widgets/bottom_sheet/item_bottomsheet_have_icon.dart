
// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';

import '../../constants/app_theme.dart';
import '../divider/divider.dart';

class ItemBottomSheetHaveIcon extends StatelessWidget {
  const ItemBottomSheetHaveIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress,
    this.useDivider = true,
  });

  final String icon, title;
  final bool useDivider;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.dimens_16),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(icon, height: Dimens.dimens_15, color: Theme.of(context).colorScheme.onSurfaceVariant),
                Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: AppThemeData.regular,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (useDivider) _divider(context),
        ],
      ),
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.onTertiaryContainer);
}
