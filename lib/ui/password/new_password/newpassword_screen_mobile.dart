
// ignore_for_file: avoid_multiple_declarations_per_line, inference_failure_on_instance_creation


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/contained_button.dart';

import '../../../constants/assets.dart';
import '../../../utils/regex/regex.dart';
import '../../../widgets/components/logo_theshow.dart';
import '../../../widgets/components/termsofuser_and_privacypolicy.dart';
import '../../../widgets/components/title_screen.dart';
import '../../../widgets/input/basic_text_field.dart';
import '../../../widgets/text/rich_text_link.dart';
import '../../success_fail/success_fail_screen.dart';

class NewPasswordScreenMobile extends StatefulWidget {
  const NewPasswordScreenMobile({
    super.key,
  });

  @override
  State<NewPasswordScreenMobile> createState() => _NewPasswordScreenMobileState();
}

class _NewPasswordScreenMobileState extends State<NewPasswordScreenMobile> {

  final GlobalKey<FormState> _formNewPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildBody(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
            TermsOfUseAndPrivacyPolicy(title: 'login_mg6'.tr(context)),
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
            TitleScreen(title: 'password_mg3'.tr(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_30)),
            _buildInput(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_25)),
            _buildButtonSaveNewPassword(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_40)),
            _buildNavigateSignUp(context),
          ],
        ),
      ),
    );
  }

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

  Widget _buildButtonSaveNewPassword(BuildContext context) {
    return ContainedButton(
      title: 'password_mg5'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: _handleLogicSaveNewPassword,
    );
  }

  Future<void> _handleLogicSaveNewPassword() async {
    if (!_formNewPassword.currentState!.validate()) {
      return;
    }
    await _navigateToSuccessOrFail(true);
  }

  Future<void> _navigateToSuccessOrFail(bool isSuccess) async {
    if (isSuccess) {
      await Navigator.of(context).pushAndRemoveUntil(
        _pageRouteSuccessOrFail(isSuccess), (route) => false,
      );
    } else {
      await Navigator.of(context).push(
        _pageRouteSuccessOrFail(isSuccess),
      );
    }
  }

  MaterialPageRoute<dynamic> _pageRouteSuccessOrFail(bool isSuccess) {
    return MaterialPageRoute(
      builder: (context) {
        return SuccessFailScreen(
          imageBackground: isSuccess ? Assets.success : Assets.fail,
          titleNoti: isSuccess ? 'successfail_mg4' : 'successfail_mg2',
          contentNoti: isSuccess ? 'successfail_mg5' : 'successfail_mg3',
          actions: _buildActionsSuccessOrFail(context, isSuccess),
        );
      },
    );
  }

  Widget _buildActionsSuccessOrFail(BuildContext context, bool isSuccess) {
    return ContainedButton(
      title: (isSuccess ? 'login_mg0' : 'successfail_mg6').tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: () => _handleLogicActionsSuccessOrFail(isSuccess),
    );
  }

  Future<void> _handleLogicActionsSuccessOrFail(bool isSuccess) async {
    if (isSuccess) {
      await navigation.navigatePushAndRemoveUntil(RouterName.login);
    } else {
      navigation.pop();
    }
  }

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formNewPassword,
      child: Column(
        children: [
          BasicTextField(
            controller: TextEditingController(),
            regexConfig: RegexConstant.password,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'password_mg4'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BasicTextField(
            controller: TextEditingController(),
            confirmController: TextEditingController(text: 'Son123.'),
            regexConfig: RegexConstant.password,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'signup_mg2'.tr(context),
          ),
        ],
      ),
    );
  }

}
