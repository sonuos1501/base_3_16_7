
// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/app_theme.dart';

class SuccessFailScreenDesktop extends StatelessWidget {
  const SuccessFailScreenDesktop({
    super.key,
    required this.imageBackground,
    required this.titleNoti,
    required this.contentNoti,
    this.actions,
  });

  final String imageBackground;
  final String titleNoti, contentNoti;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'warning_mg0'.tr(context),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: AppThemeData.medium,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
