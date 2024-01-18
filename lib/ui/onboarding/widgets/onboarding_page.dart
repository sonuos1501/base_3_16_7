// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/components/logo_theshow.dart';

import '../../../constants/app_theme.dart';
import '../../../widgets/button/contained_button.dart';

class ParamsOnboardingPage {
  const ParamsOnboardingPage({
    required this.background,
    required this.title,
    required this.content,
  });

  final String background, title, content;
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.paramsOnboardingPage,
    required this.onPress,
  });

  final ParamsOnboardingPage paramsOnboardingPage;
  final AsyncCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Gap(Dimens.dimens_10),
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: LogoTheShow(),
              ),
            ),
            Expanded(flex: 12, child: _buildBackgroundOnboarding(context)),
            Expanded(
              flex: 1,
              child: _buildTitle(context),
            ),
            const Gap(Dimens.dimens_05),
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 0.6,
                alignment: Alignment.centerLeft,
                child: _buildContent(context),
              ),
            ),
            const Gap(Dimens.dimens_10),
            Expanded(
              flex: 1,
              child: _buildButton(context),
            ),
            const Gap(Dimens.dimens_10),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerRight,
      child: ContainedButton(
        title: 'next'.tr(context),
        size: const Size(Dimens.dimens_132, Dimens.dimens_44),
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        onPress: onPress,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerLeft,
      child: Text(
        paramsOnboardingPage.content.tr(context),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerLeft,
      child: Text(
        paramsOnboardingPage.title.tr(context),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: AppThemeData.semiBold,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
      ),
    );
  }

  Widget _buildBackgroundOnboarding(BuildContext context) {
    return Center(
      child: Image.asset(
        paramsOnboardingPage.background,
        fit: BoxFit.contain,
      ),
    );
  }
}
