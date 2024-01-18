import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';

class BuildDropdownItem extends StatelessWidget {
  const BuildDropdownItem({
    super.key,
    required this.content,
    required this.status,
  });

  final String content;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            content,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.surfaceVariant,
              fontWeight: AppThemeData.regular,
            ),
          ),
        ),
        if (status) const Icon(Icons.close, color: Colors.red, size: 15)
      ],
    );
  }
}
