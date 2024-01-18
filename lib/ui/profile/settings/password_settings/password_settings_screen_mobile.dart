import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/ui/profile/settings/password_settings/bloc/password_settings_bloc.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/dimens.dart';
import '../../../../utils/regex/regex.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../../widgets/button/contained_button.dart';
import '../../../../widgets/button/cs_icon_button.dart';
import '../../../../widgets/divider/divider.dart';
import '../../../../widgets/input/basic_text_field.dart';

class PasswordSettingsScreenMobile extends StatefulWidget {
  const PasswordSettingsScreenMobile({super.key});

  @override
  State<PasswordSettingsScreenMobile> createState() => _PasswordSettingsScreenMobileState();
}

class _PasswordSettingsScreenMobileState extends State<PasswordSettingsScreenMobile> {
  late final _controller = BlocProvider.of<PasswordSettingsBloc>(context, listen: false);

  final _currentPasswordEdtCtrl = TextEditingController();
  final _newPasswordEdtCtrl = TextEditingController();
  final _confirmNewPasswordEdtCtrl = TextEditingController();

  final _formPasswordSettingsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'password'.tr(context)),
      body: SafeArea(
        child: BlocListener<PasswordSettingsBloc, PasswordSettingsState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: LoadingProcessBuilder.showProgressDialog,
              fail: (errors) async {
                Utils.showToast(context, errors ?? 'Error', status: false);
                await LoadingProcessBuilder.closeProgressDialog();
              },
              success: (message) async {
                Utils.showToast(context, message ?? 'Changed password successful');
                await LoadingProcessBuilder.closeProgressDialog();
              },
            );
          },
          child: Column(
            children: [
              _divider(context),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
    child: Column(
      children: [
        Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        _buildInput(context),
        Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
        _buildButtonSavePassword(context),
      ],
    ),
  );

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formPasswordSettingsKey,
      child: Column(
        children: [
          BlocBuilder<PasswordSettingsBloc, PasswordSettingsState>(
            buildWhen: (previous, current) => current is PasswordSettingsSeeCurrentPasswordState && current != previous,
            builder: (context, state) {
              var sawPw = true;
              if (state is PasswordSettingsSeeCurrentPasswordState) {
                sawPw = state.seeCurrentPassword;
              }

              return BasicTextField(
                controller: _currentPasswordEdtCtrl,
                regexConfig: RegexConstant.notEmpty,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'settings_mg0'.tr(context),
                isPassword: sawPw,
                suffixIcon: CsIconButton(
                  image: !sawPw ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async => _handleLogicSeeAndUnseeCurrentPassword(sawPw),
                ),
              );
            },
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BlocBuilder<PasswordSettingsBloc, PasswordSettingsState>(
            buildWhen: (previous, current) => current is PasswordSettingsSeeNewPasswordState && current != previous,
            builder: (context, state) {
              var sawPw = true;
              if (state is PasswordSettingsSeeNewPasswordState) {
                sawPw = state.seeNewPassword;
              }

              return BasicTextField(
                controller: _newPasswordEdtCtrl,
                regexConfig: RegexConstant.notEmpty,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'password_mg3'.tr(context),
                isPassword: sawPw,
                suffixIcon: CsIconButton(
                  image: !sawPw ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async => _handleLogicSeeAndUnseeNewPassword(sawPw),
                ),
              );
            },
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          BlocBuilder<PasswordSettingsBloc, PasswordSettingsState>(
            buildWhen: (previous, current) => current is PasswordSettingsSeeConfirmNewPasswordState && current != previous,
            builder: (context, state) {
              var sawPw = true;
              if (state is PasswordSettingsSeeConfirmNewPasswordState) {
                sawPw = state.seeConfirmNewPassword;
              }

              return BasicTextField(
                controller: _confirmNewPasswordEdtCtrl,
                confirmController: _newPasswordEdtCtrl,
                regexConfig: RegexConstant.notEmpty,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'settings_mg1'.tr(context),
                isPassword: sawPw,
                suffixIcon: CsIconButton(
                  image: !sawPw ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async => _handleLogicSeeAndUnseeConfirmNewPassword(sawPw),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogicSeeAndUnseeCurrentPassword(bool seePW) async {
    _controller.add(PasswordSettingsEvent.sawCurrentPassword(sawCurrentPassword: !seePW));
  }

  Future<void> _handleLogicSeeAndUnseeNewPassword(bool seePW) async {
    _controller.add(PasswordSettingsEvent.sawNewPassword(sawNewPassword: !seePW));
  }

  Future<void> _handleLogicSeeAndUnseeConfirmNewPassword(bool seePW) async {
    _controller.add(PasswordSettingsEvent.sawConfirmNewPassword(sawConfirmNewPassword: !seePW));
  }

  Widget _buildButtonSavePassword(BuildContext context) => ContainedButton(
    title: 'password_mg5'.tr(context),
    size: const Size(double.infinity, Dimens.dimens_44),
    color: Theme.of(context).colorScheme.onSecondaryContainer,
    onPress: _handleLogicSavePassword,
  );

  Future<void> _handleLogicSavePassword() async {
    if (!_formPasswordSettingsKey.currentState!.validate()) {
      return;
    }
    _controller.add(PasswordSettingsEvent.savedChangePassword(
      newPassword: _newPasswordEdtCtrl.text.trim(),
      confirmNewPassword: _confirmNewPasswordEdtCtrl.text.trim(),
      currentPassword: _currentPasswordEdtCtrl.text.trim(),
    ),);
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
