import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/regex/regex.dart';
import 'package:theshowplayer/widgets/input/basic_text_field.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceTint,
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(top: Dimens.dimens_10, bottom: Dimens.dimens_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'comments'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    fontWeight: AppThemeData.medium,
                  ),
                ),
                TextSpan(
                  text: '  3',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Gap(Dimens.dimens_08),
          BasicTextField(regexConfig: RegexConstant.idCardNumber, hintText: 'enter_your_comment_here'.tr(context),)
        ],
      ),
    );
  }
}
