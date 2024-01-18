
// ignore_for_file: avoid_multiple_declarations_per_line


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/contained_button.dart';

import '../../../widgets/components/logo_theshow.dart';
import '../../../widgets/components/termsofuser_and_privacypolicy.dart';
import '../../../widgets/components/title_screen.dart';
import '../../../widgets/text/rich_text_link.dart';

class VerificationScreenMobile extends StatefulWidget {
  const VerificationScreenMobile({
    super.key,
  });

  @override
  State<VerificationScreenMobile> createState() => _VerificationScreenMobileState();
}

class _VerificationScreenMobileState extends State<VerificationScreenMobile> {

  final GlobalKey<FormState> _formOtpPassword = GlobalKey<FormState>();

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
            TitleScreen(title: 'password_mg6'.tr(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
            _buildSubTitle(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_50)),
            _buildInput(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_25)),
            _buildButtonVerify(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_40)),
            _buildNavigateSignUp(context),
          ],
        ),
      ),
    );
  }

  Text _buildSubTitle(BuildContext context) {
    return Text(
      'password_mg7'.tr(context),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.regular,
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

  Widget _buildButtonVerify(BuildContext context) {
    return ContainedButton(
      title: 'password_mg8'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: _handleLogicVerify,
    );
  }

  Future<void> _handleLogicVerify() async {
    if (!_formOtpPassword.currentState!.validate()) {
      return;
    }
    await navigation.navigatePushAndRemoveUntil(RouterName.newPassword);
  }

  Widget _buildInput(BuildContext context) {
    const lengthOtp = 4;
    return Form(
      key: _formOtpPassword,
      child: PinCodeTextField(
        appContext: context,
        controller: TextEditingController(),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        pastedTextStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          fontWeight: AppThemeData.bold,
        ),
        errorTextSpace: Dimens.dimens_30,
        length: lengthOtp,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (v) {
          if (v!.length < lengthOtp) {
            return 'input_mg3'.tr(context);
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          selectedColor: Theme.of(context).colorScheme.outline,
          inactiveColor: Theme.of(context).colorScheme.onTertiaryContainer,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(Dimens.dimens_11),
          fieldHeight: Dimens.dimens_44,
          fieldWidth: Dimens.dimens_44,
          activeFillColor: Theme.of(context).colorScheme.surface,
          errorBorderColor: Theme.of(context).colorScheme.error,
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          debugPrint('Completed');
        },
        // onTap: () {
        //   print("Pressed");
        // },
        onChanged: (value) {
          debugPrint(value);
          setState(() {
            // currentText = value;
          });
        },
        beforeTextPaste: (text) {
          debugPrint('Allowing to paste $text');
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }

}
