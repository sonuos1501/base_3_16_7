import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';

import '../../constants/app_theme.dart';

class AddMoreItem extends StatelessWidget {
  const AddMoreItem({ super.key, required this.onPress });

  final AsyncCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _divider(context),
        Gap(ScreenUtil().setWidth(Dimens.dimens_16)),
        _more(context),
        Gap(ScreenUtil().setWidth(Dimens.dimens_16)),
        _divider(context),
      ],
    );
  }

  Widget _more(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_16, vertical: Dimens.dimens_10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Theme.of(context).colorScheme.surfaceTint),
          borderRadius: BorderRadius.circular(Dimens.dimens_20),
        ),
        child: Text(
          'more'.tr(context),
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: AppThemeData.medium,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Expanded(child: CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint));
  }

}
