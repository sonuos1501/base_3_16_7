import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.empty),
          const Gap(Dimens.dimens_15),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: AppThemeData.regular,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
