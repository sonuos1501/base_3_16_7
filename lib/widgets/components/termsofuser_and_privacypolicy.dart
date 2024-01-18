// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';
import '../text/rich_text_link.dart';

class TermsOfUseAndPrivacyPolicy extends StatelessWidget {
  const TermsOfUseAndPrivacyPolicy({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: RichTextWidget(
        textAlign: TextAlign.center,
        texts: [
          BaseText.plain(
            text: '$title\n',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: AppThemeData.medium,
            ),
          ),
          BaseText.link(
            text: 'login_mg7'.tr(context),
            onTapped: _onPressTermsOfUse,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.outline,
              fontWeight: AppThemeData.medium,
            ),
          ),
          BaseText.plain(
            text: ' & ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: AppThemeData.medium,
            ),
          ),
          BaseText.link(
            text: 'login_mg8'.tr(context),
            onTapped: _onPressPrivacyPolicy,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.outline,
              fontWeight: AppThemeData.medium,
            ),
          ),
        ],
      ),
    );
  }

  void _onPressTermsOfUse() {
  }

  void _onPressPrivacyPolicy() {
  }
}
