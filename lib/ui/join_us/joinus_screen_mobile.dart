
// ignore_for_file: avoid_multiple_declarations_per_line


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../widgets/components/logo_theshow.dart';
import '../../widgets/components/termsofuser_and_privacypolicy.dart';
import '../../widgets/components/title_screen.dart';
import '../../widgets/text/rich_text_link.dart';

class JoinUsScreenMobile extends StatelessWidget {
  const JoinUsScreenMobile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildBody(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
            TermsOfUseAndPrivacyPolicy(title: 'joinus_mg1'.tr(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(ScreenUtil().setHeight(Dimens.dimens_50)),
            const LogoTheShow(),
            Gap(ScreenUtil().setHeight(Dimens.dimens_23)),
            TitleScreen(title: 'joinus_mg0'.tr(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_23)),
            _buildTypesOfLogin(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
            _buildNavigateSignUp(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypesOfLogin(BuildContext context) {
    return Column(
      children: [
        ButtonTypesLogin(icon: Assets.icGoogle, title: 'joinus_mg3'.tr(context), onPress: _handleLogicNavigateToSignUpWithGoogle),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        ButtonTypesLogin(icon: Assets.icKaKaoTalk, title: 'joinus_mg4'.tr(context), onPress: _handleLogicNavigateToSignUpWithKakaotalk),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        ButtonTypesLogin(icon: Assets.icNaver, title: 'joinus_mg5'.tr(context), onPress: _handleLogicNavigateToSignUpWithNaver),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        ButtonTypesLogin(title: 'joinus_mg6'.tr(context), onPress: _handleLogicNavigateToSignUpWithTraditional),
      ],
    );
  }

  Future<void> _handleLogicNavigateToSignUpWithTraditional() async => navigation.navigateTo(RouterName.signup);

  Future<void> _handleLogicNavigateToSignUpWithNaver() async {}

  Future<void> _handleLogicNavigateToSignUpWithKakaotalk() async {}

  Future<void> _handleLogicNavigateToSignUpWithGoogle() async {}

  Widget _buildNavigateSignUp(BuildContext context) {
    return RichTextWidget(
      texts: [
        BaseText.plain(
          text: '${'joinus_mg2'.tr(context)} ',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.medium,
          ),
        ),
        BaseText.link(
          text: 'login_mg0'.tr(context),
          onTapped: _handleLogicNavigateToLoginScreen,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.outline,
            fontWeight: AppThemeData.medium,
          ),
        ),
      ],
    );
  }

  void _handleLogicNavigateToLoginScreen() => navigation.navigatePushAndRemoveUntil(RouterName.login);

}

class ButtonTypesLogin extends StatelessWidget {
  const ButtonTypesLogin({
    super.key,
    required this.title,
    required this.onPress,
    this.icon,
  });

  final String title;
  final String? icon;
  final AsyncCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_05, vertical: Dimens.dimens_11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dimens_12),
          border: Border.all(width: 1, color: Theme.of(context).colorScheme.onTertiaryContainer),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const Gap(Dimens.dimens_08),
            Flexible(child: _buildTitle(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return icon == null ? const SizedBox.shrink() : SvgPicture.asset(icon!, height: ScreenUtil().setWidth(Dimens.dimens_24));
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.medium,
      ),
    );
  }
}
