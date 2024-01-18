import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:theshowplayer/constants/dimens.dart';

PersistentBottomNavBarItem persistentBottomNavBarItem(
  BuildContext context, {
  required String activeIconPath,
  required String inactiveIconPath,
  required String title,
}) {
  return PersistentBottomNavBarItem(
    icon: _svgIcon(
      activeIconPath,
    ),
    inactiveIcon: _svgIcon(
      inactiveIconPath,
    ),
    title: title,
    activeColorPrimary: Theme.of(context).colorScheme.surfaceVariant,
    inactiveColorPrimary: Theme.of(context).colorScheme.onTertiaryContainer,
  );
}

Widget _svgIcon(String url, {Color? color}) {
  return SvgPicture.asset(
    url,
    height: Dimens.dimens_24,
    width: Dimens.dimens_24,
    fit: BoxFit.cover,
    color: color,
  );
}
