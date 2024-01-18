
import 'package:base_3_16_7/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';

class LoginScreenIpad extends StatelessWidget {
  const LoginScreenIpad({
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
