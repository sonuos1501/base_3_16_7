
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/blocs/common_blocs/language/language_bloc.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/contained_button.dart';

import '../../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../../widgets/button/base_outline_button.dart';
import '../../../../widgets/divider/divider.dart';


class LanguagesSettingsScreenMobile extends StatelessWidget {
  const LanguagesSettingsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'languages'.tr(context)),
      body: SafeArea(
        child: Column(
          children: [
            _divider(context),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.dimens_25),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimens.dimens_15,
              mainAxisSpacing: Dimens.dimens_15,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              final language = supportedLanguages[index];
              return _itemLanguage(
                context,
                title: language.language ?? '',
                chooseLanguage: state.language.locale == language.locale,
                onPress: () async {
                  BlocProvider.of<LanguageBloc>(context, listen: false).add(LanguageEvent.changedLanguage(localeLanguage: language.locale ?? 'en'));
                },
              );
            },
            itemCount: supportedLanguages.length,
          );
        },
      ),
    );
  }

  Widget _itemLanguage(
    BuildContext context, {
    required String title,
    required bool chooseLanguage,
    required AsyncCallback onPress,
  }) {
    return chooseLanguage
      ? ContainedButton(
        title: title,
        borderRadius: Dimens.dimens_08,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        size: const Size(double.infinity, Dimens.dimens_45),
        onPress: onPress,
      )
      : BaseOutlineButton(
        title: title,
        borderRadius: Dimens.dimens_08,
        colorBorderAndTitle: Theme.of(context).colorScheme.onSurfaceVariant,
        size: const Size(double.infinity, Dimens.dimens_45),
        onPress: onPress,
      );
  }


  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
