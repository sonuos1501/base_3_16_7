import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.semiBold,
          ),
    );
  }
}
