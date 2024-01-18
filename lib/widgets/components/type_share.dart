
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';
import '../button/common_button.dart';

class TypeShare extends StatelessWidget {
  const TypeShare({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.onPress,
  });

  final BuildContext context;
  final String icon;
  final String title;
  final AsyncCallback? onPress;

  @override
  Widget build(BuildContext context) {
    const size = Dimens.dimens_50;

    return CommonButton(
      onPress: onPress,
      child: Column(
        children: [
          SvgPicture.asset(icon, height: size),
          Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
          SizedBox(
            width: size + Dimens.dimens_10,
            child: Text(
              title.tr(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: AppThemeData.regular,
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleShare extends StatelessWidget {
  const TitleShare({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(
      'share_to'.tr(context),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.semiBold,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }
}
