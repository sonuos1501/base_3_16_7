import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';

class TagStatus extends StatelessWidget {
  const TagStatus({ super.key, required this.title, required this.backgroundColor });

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return _buildTags(context);
  }

  Widget _buildTags(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_06, vertical: Dimens.dimens_03),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimens.dimens_06),
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: AppThemeData.regular,
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ),
    );
  }

}
