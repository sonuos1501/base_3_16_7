// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocation


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/dialog/dialog.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../../constants/app_theme.dart';
import '../../../../constants/assets.dart';
import '../../../../di/action_method_locator.dart';
import '../../../../utils/regex/regex.dart';
import '../../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../../widgets/button/base_outline_button.dart';
import '../../../../widgets/button/contained_button.dart';
import '../../../../widgets/button/cs_icon_button.dart';
import '../../../../widgets/divider/divider.dart';
import '../../../../widgets/input/basic_text_field.dart';
import '../../../success_fail/success_fail_screen.dart';
import 'bloc/delete_account_bloc.dart';

class DeleteAccountScreenMobile extends StatefulWidget {
  const DeleteAccountScreenMobile({super.key});

  @override
  State<DeleteAccountScreenMobile> createState() => _DeleteAccountScreenMobileState();
}

class _DeleteAccountScreenMobileState extends State<DeleteAccountScreenMobile> {
  final _formDeleteAccountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'delete_account'.tr(context)),
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: Column(
        children: [
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
          _buildInput(context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_35)),
          _buildButtonDelete(context),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formDeleteAccountKey,
      child: Column(
        children: [
          BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
            buildWhen: (previous, current) => current is DeleteAccountSeePasswordState && current != previous,
            builder: (context, state) {
              var sawPw = true;
              if (state is DeleteAccountSeePasswordState) {
                sawPw = state.seePassword;
              }

              return BasicTextField(
                controller: TextEditingController(text: 'Son123.'),
                regexConfig: RegexConstant.password,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'password'.tr(context),
                isPassword: sawPw,
                suffixIcon: CsIconButton(
                  image: !sawPw ? Assets.icEge : Assets.icEgeUnsee,
                  padding: const EdgeInsets.only(right: Dimens.dimens_12),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPress: () async => _handleLogicSeeAndUnseePassword(sawPw),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogicSeeAndUnseePassword(bool seePW) async {
    BlocProvider.of<DeleteAccountBloc>(context, listen: false).add(DeleteAccountEvent.sawPassword(sawPassword: !seePW));
  }

  Widget _buildButtonDelete(BuildContext context) => ContainedButton(
    title: 'delete'.tr(context),
    size: const Size(double.infinity, Dimens.dimens_44),
    color: Theme.of(context).colorScheme.onSecondaryContainer,
    onPress: _handleLogicDeleteAccount,
  );

  Future<void> _handleLogicDeleteAccount() async {
    if (!_formDeleteAccountKey.currentState!.validate()) {
      return;
    }
    final result = await _builDialogDeleteAccount();
    if (result ?? false) {
      await _navigateToSuccessOrFail(true);
    }
  }

  Future<bool?> _builDialogDeleteAccount() async {
    return DialogUtils.buildBaseDialog(
      context,
      header: SvgPicture.asset(Assets.icTrashCan,height: Dimens.dimens_28, color: Theme.of(context).colorScheme.onInverseSurface),
      body: Column(
        children: [
          Text(
            'delete_account'.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.surfaceVariant,
              fontWeight: AppThemeData.medium,
            ),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
          Text(
            'settings_mg4'.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.surfaceVariant,
              fontWeight: AppThemeData.regular,
            ),
          ),
        ],
      ),
      actions: [
        _buildActionDialog(
          context,
          title: 'cancel',
          backgroundColor: Theme.of(context).colorScheme.background,
          onPress: () async => navigation.pop(result: false),
        ),
        const Gap(Dimens.dimens_10),
        _buildActionDialog(
          context,
          title: 'delete',
          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          onPress: () async => navigation.pop(result: true),
        ),
      ],
    );
  }

  Widget _buildActionDialog(
    BuildContext context, {
    required String title,
    required Color backgroundColor,
    required AsyncCallback onPress,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
        child: ContainedButton(
          title: title.tr(context),
          size: const Size(double.infinity, Dimens.dimens_44),
          color: backgroundColor,
          onPress: onPress,
        ),
      ),
    );
  }

  Future<void> _navigateToSuccessOrFail(bool isSuccess) async {
    if (isSuccess) {
      await Navigator.of(context).pushAndRemoveUntil(
        _pageRouteSuccessOrFail(isSuccess),
        (route) => false,
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
          contentNoti: isSuccess ? 'settings_mg3' : 'successfail_mg3',
          actions: isSuccess ? _buildActionsSuccess(context) : _buildActionsFail(context),
        );
      },
    );
  }

  Widget _buildActionsFail(BuildContext context) {
    return ContainedButton(
      title: 'successfail_mg6'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: () async => navigation.pop(),
    );
  }

  Widget _buildActionsSuccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseOutlineButton(
            title: 'login_mg0'.tr(context),
            borderRadius: Dimens.dimens_12,
            colorBorderAndTitle: Theme.of(context).colorScheme.onSurfaceVariant,
            size: const Size(double.infinity, Dimens.dimens_44),
            onPress: () async => navigation.navigatePushAndRemoveUntil(RouterName.login),
          ),
        ),
        Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
        Expanded(
          child: ContainedButton(
            title: 'signup_mg0'.tr(context),
            size: const Size(double.infinity, Dimens.dimens_44),
            borderRadius: Dimens.dimens_12,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            onPress: () async => navigation.navigatePushAndRemoveUntil(RouterName.joinus),
          ),
        ),
      ],
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);
}
