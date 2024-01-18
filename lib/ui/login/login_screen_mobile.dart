// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/button/contained_button.dart';
import 'package:theshowplayer/widgets/button/cs_icon_button.dart';

import '../../utils/regex/regex.dart';
import '../../utils/utils.dart';
import '../../widgets/components/authen3party.dart';
import '../../widgets/components/logo_theshow.dart';
import '../../widgets/components/termsofuser_and_privacypolicy.dart';
import '../../widgets/components/title_screen.dart';
import '../../widgets/input/basic_text_field.dart';
import '../../widgets/text/rich_text_link.dart';
import 'bloc/login_bloc.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({
    super.key,
  });

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();

  final _userNameEdtCtrl = TextEditingController();
  final _passwordEdtCtrl = TextEditingController();

  @override
  void dispose() {
    _userNameEdtCtrl.dispose();
    _passwordEdtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: LoadingProcessBuilder.showProgressDialog,
              fail: (errors) async {
                Utils.showToast(context, errors ?? 'Error', status: false);
                await LoadingProcessBuilder.closeProgressDialog();
              },
              success: (message) async {
                Utils.showToast(context, message ?? 'Login successful');
                await LoadingProcessBuilder.closeProgressDialog();
                await navigation
                    .navigatePushAndRemoveUntil(RouterName.dashboard);
              },
            );
          },
          child: Column(
            children: [
              Expanded(child: _buildBody(context)),
              Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
              TermsOfUseAndPrivacyPolicy(
                title: 'login_mg6'.tr(context),
              ),
              Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Flexible(flex: 1, child: LogoTheShow()),
          Flexible(flex: 1, child: TitleScreen(title: 'login_mg0'.tr(context))),
          const Spacer(),
          Flexible(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInput(context),
                const Gap(10),
                _buildForgotPassword(context),
              ],
            ),
          ),
          const Gap(20),
          Flexible(flex: 1, child: _buildLogin(context)),
          Flexible(
            flex: 2,
            child: Authen3Party(
              title: 'login_mg4'.tr(context),
              onPressGoogle: _handleLogicLogicByGoogle,
              onPressKaKaoTalk: _handleLogicLogicByKaKaoTalk,
              onPressNaver: _handleLogicLogicByNaver,
            ),
          ),
          const Gap(10),
          Flexible(flex: 1, child: _buildNavigateSignUp(context)),
        ],
      ),
    );
  }

  Future<void> _handleLogicLogicByNaver() async {
    BlocProvider.of<LoginBloc>(context, listen: false)
        .add(const LoginEvent.logedInWithNaver());
  }

  Future<void> _handleLogicLogicByKaKaoTalk() async {
    BlocProvider.of<LoginBloc>(context, listen: false)
        .add(const LoginEvent.logedInWithKakao());
  }

  Future<void> _handleLogicLogicByGoogle() async {
    BlocProvider.of<LoginBloc>(context, listen: false)
        .add(const LoginEvent.logedInWithGoogle());
  }

  Widget _buildNavigateSignUp(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichTextWidget(
        texts: [
          BaseText.plain(
            text: '${'login_mg5'.tr(context)} ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.medium,
                ),
          ),
          BaseText.link(
            text: 'signup_mg0'.tr(context),
            onTapped: _handleLogicNavigateToSignUpScreen,
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

  void _handleLogicNavigateToSignUpScreen() =>
      navigation.navigatePushAndRemoveUntil(RouterName.joinus);

  Widget _buildLogin(BuildContext context) {
    return ContainedButton(
      title: 'login_mg0'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: _handleLogicLogin,
    );
  }

  Future<void> _handleLogicLogin() async {
    if (!_formLogin.currentState!.validate()) {
      return;
    }
    BlocProvider.of<LoginBloc>(context, listen: false).add(
      LoginEvent.logedInTraditional(
        username: _userNameEdtCtrl.text.trim(),
        password: _passwordEdtCtrl.text.trim(),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return CommonButton(
      onPress: _handleLogicNavigateToForgotPasswordScreen,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'login_mg3'.tr(context),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: AppThemeData.medium,
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
        ),
      ),
    );
  }

  Future<void> _handleLogicNavigateToForgotPasswordScreen() async =>
      navigation.navigatePushAndRemoveUntil(RouterName.resetPassword);

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BasicTextField(
            controller: _userNameEdtCtrl,
            regexConfig: RegexConstant.notEmpty,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'login_mg1'.tr(context),
          ),
          const Gap(16),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                current is LoginSeePWState && current != previous,
            builder: (context, loginState) {
              var sawPW = true;
              if (loginState is LoginSeePWState) {
                sawPW = loginState.seePassword;
              }

              return BasicTextField(
                controller: _passwordEdtCtrl,
                regexConfig: RegexConstant.notEmpty,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'login_mg2'.tr(context),
                isPassword: sawPW,
                suffixIcon: CsIconButton(
                  image: !sawPW ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async =>
                      _handleLogicSeeAndUnseePassword(context, sawPW),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _handleLogicSeeAndUnseePassword(
    BuildContext context,
    bool seePW,
  ) async {
    BlocProvider.of<LoginBloc>(context, listen: false)
        .add(LoginEvent.sawPassword(sawThePassword: !seePW));
  }
}
