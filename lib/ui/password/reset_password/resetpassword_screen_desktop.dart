
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../constants/app_theme.dart';

class ResetPasswordScreenDesktop extends StatelessWidget {
  const ResetPasswordScreenDesktop({
    super.key,
  });

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
