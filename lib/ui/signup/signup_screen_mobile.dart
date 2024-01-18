// ignore_for_file: avoid_multiple_declarations_per_line, inference_failure_on_instance_creation, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/blocs/common_blocs/authentication/authentication_bloc.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/ui/success_fail/success_fail_screen.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/contained_button.dart';
import 'package:theshowplayer/widgets/button/cs_icon_button.dart';
import 'package:theshowplayer/widgets/dropdown/select_drop_list.dart';
import 'package:theshowplayer/widgets/loading/loading_indicator.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';

import '../../configs/routers/router_name.dart';
import '../../di/action_method_locator.dart';
import '../../utils/regex/regex.dart';
import '../../utils/utils.dart';
import '../../widgets/components/authen3party.dart';
import '../../widgets/components/logo_theshow.dart';
import '../../widgets/components/termsofuser_and_privacypolicy.dart';
import '../../widgets/components/title_screen.dart';
import '../../widgets/input/basic_text_field.dart';
import 'bloc/signup_bloc.dart';

class SignUpScreenMobile extends StatefulWidget {
  const SignUpScreenMobile({
    super.key,
  });

  @override
  State<SignUpScreenMobile> createState() => _SignUpScreenMobileState();
}

class _SignUpScreenMobileState extends State<SignUpScreenMobile> {
  late final _controller = BlocProvider.of<SignUpBloc>(context, listen: false);

  final _userNameEdtCtrl = TextEditingController();
  final _emailEdtCtrl = TextEditingController();
  final _passwordEdtCtrl = TextEditingController();
  final _confirmPasswordEdtCtrl = TextEditingController();

  final GlobalKey<FormState> _formSignUp = GlobalKey<FormState>();
  String _selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: LoadingProcessBuilder.showProgressDialog,
              fail: (errors) async {
                Utils.showToast(context, errors ?? 'Error', status: false);
                await _navigateToSuccessOrFail(false);
                await LoadingProcessBuilder.closeProgressDialog();
              },
              success: (userId, cookie) async {
                BlocProvider.of<AuthenticationBloc>(context, listen: false).add(
                  AuthenticationEvent.loggedIn(
                    userId: userId,
                    token: cookie,
                    loginType: LoginType.traditional,
                  ),
                );
                await _navigateToSuccessOrFail(true);
                await LoadingProcessBuilder.closeProgressDialog();
              },
            );
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: _buildBody(context)),
                  Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
                  TermsOfUseAndPrivacyPolicy(title: 'login_mg6'.tr(context)),
                  Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
                ],
              ),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpLoadingState) {
                    return const LoadingView();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
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
            TitleScreen(title: 'signup_mg0'.tr(context)),
            Gap(ScreenUtil().setHeight(Dimens.dimens_23)),
            _buildInput(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
            _buildSignUp(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_26)),
            Authen3Party(
              title: 'signup_mg6'.tr(context),
              onPressGoogle: _handleLogicLogicByGoogle,
              onPressKaKaoTalk: _handleLogicLogicByKaKaoTalk,
              onPressNaver: _handleLogicLogicByNaver,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogicLogicByNaver() async {}

  Future<void> _handleLogicLogicByKaKaoTalk() async {}

  Future<void> _handleLogicLogicByGoogle() async {}

  Widget _buildSignUp(BuildContext context) {
    return ContainedButton(
      title: 'signup_mg0'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: _handleLogicSignUp,
    );
  }

  Future<void> _handleLogicSignUp() async {
    if (!_formSignUp.currentState!.validate()) {
      return;
    }
    _controller.add(SignUpEvent.pressedSignUp(
      userName: _userNameEdtCtrl.text.trim(),
      password: _passwordEdtCtrl.text.trim(),
      confirmPassword: _confirmPasswordEdtCtrl.text.trim(),
      email: _emailEdtCtrl.text.trim(),
      gender: _selectedGender.isEmpty ? null : _selectedGender,
    ),);
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
          titleNoti: isSuccess ? 'successfail_mg0' : 'successfail_mg2',
          contentNoti: isSuccess ? 'successfail_mg1' : 'successfail_mg3',
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
      await navigation.navigatePushAndRemoveUntil(RouterName.dashboard);
    } else {
      navigation.pop();
    }
  }

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formSignUp,
      child: Column(
        children: [
          BasicTextField(
            controller: _userNameEdtCtrl,
            regexConfig: RegexConstant.notEmpty,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'login_mg1'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BasicTextField(
            controller: _emailEdtCtrl,
            regexConfig: RegexConstant.email,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'signup_mg1'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => current is SignUpSeePWState && current != previous,
            builder: (context, signUpState) {
              var sawPW = true;
              if (signUpState is SignUpSeePWState) {
                sawPW = signUpState.seePassword;
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
                  onPress: () async => _handleLogicSeeAndUnseePassword(sawPW),
                ),
              );
            },
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => current is SignUpSeeConfirmPWState && current != previous,
            builder: (context, signUpState) {
              var sawConfirmPW = true;
              if (signUpState is SignUpSeeConfirmPWState) {
                sawConfirmPW = signUpState.seeConfirmPassword;
              }

              return BasicTextField(
                controller: _confirmPasswordEdtCtrl,
                confirmController: _passwordEdtCtrl,
                regexConfig: RegexConstant.notEmpty,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'signup_mg2'.tr(context),
                isPassword: sawConfirmPW,
                suffixIcon: CsIconButton(
                  image: !sawConfirmPW ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async => _handleLogicSeeAndUnseeConfirmPassword(sawConfirmPW),
                ),
              );
            },
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => current is SignUpInitialState && current != previous,
            builder: (context, loadState) {
              var listGender = <String>[];

              if (loadState is SignUpInitialState) {
                listGender = loadState.listGender ?? [];
              }

              return BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) => current is SignUpGenderState && current != previous,
                builder: (context, genderState) {

                  if (genderState is SignUpGenderState) {
                    _selectedGender = genderState.gender;
                  }

                  return SelectDropList(
                    content: _selectedGender.isEmpty ? '' : _selectedGender.tr(context),
                    hintText: 'signup_mg3'.tr(context),
                    usingSearch: false,
                    listItem: listGender.map((e) => DropdownItem(content: e.tr(context))).toList(),
                    onChange: (index) {
                      if (_selectedGender == listGender[index]) {
                        _controller.add(const SignUpEvent.choosedGender(gender: ''));
                        return;
                      }
                      _controller.add(SignUpEvent.choosedGender(gender: listGender[index]));
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogicSeeAndUnseePassword(bool seePW) async {
    _controller.add(SignUpEvent.sawPassword(sawThePassword: !seePW));
  }

  Future<void> _handleLogicSeeAndUnseeConfirmPassword(bool seePW) async {
    _controller.add(SignUpEvent.sawConfirmPassword(sawTheConfirmPassword: !seePW));
  }
}
