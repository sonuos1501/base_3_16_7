import 'package:flutter/material.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

class LikeVideosTabDesktop extends StatelessWidget {
  const LikeVideosTabDesktop({super.key});

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
