
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';
import '../../constants/assets.dart';
import '../../constants/dimens.dart';
import '../../di/action_method_locator.dart';
import '../button/cs_icon_button.dart';

class AppBarViewNotLogo extends AppBar {
  AppBarViewNotLogo({
    super.key,
    required String title,
    Widget? titleCustom,
    super.actions,
  }) : super(
    leading: const BackIconAppbar(),
    title: titleCustom ?? TitleAppbar(title: title),
    titleSpacing: -(Dimens.horizontal_padding / 2),
    centerTitle: false,
  );

}

class ButtonIconAction extends StatelessWidget {
  const ButtonIconAction({
    super.key,
    required this.icon,
    required this.onTab,
  });

  final String icon;
  final AsyncCallback onTab;

  @override
  Widget build(BuildContext context) {
    return CsIconButton(
      image: icon,
      height: Dimens.dimens_19,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      color: Theme.of(context).colorScheme.surfaceVariant,
      onPress: onTab,
    );
  }
}

class TitleAppbar extends StatelessWidget {
  const TitleAppbar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.medium,
      ),
    );
  }
}

class BackIconAppbar extends StatelessWidget {
  const BackIconAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: CsIconButton(
        image: Assets.icArrowBack,
        height: Dimens.dimens_13,
        color: Theme.of(context).colorScheme.surfaceVariant,
        onPress: () async => navigation.pop(),
      ),
    );
  }
}
