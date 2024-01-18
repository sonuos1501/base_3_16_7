import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/dimens.dart';
import '../../../utils/regex/regex.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/button/contained_button.dart';
import '../../../widgets/divider/divider.dart';
import '../../../widgets/input/basic_text_field.dart';


class HelpScreenMobile extends StatefulWidget {
  const HelpScreenMobile({super.key});

  @override
  State<HelpScreenMobile> createState() => _HelpScreenMobileState();
}

class _HelpScreenMobileState extends State<HelpScreenMobile> {

  final GlobalKey<FormState> _formSubmitHelp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'profile_mg6'.tr(context)),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _divider(context),
              Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
              _buildBody(context),
              Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInput(context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_24)),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return Form(
      key: _formSubmitHelp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleInput(context, 'profile_mg13'.tr(context)),
          Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
          BasicTextField(
            controller: TextEditingController(),
            regexConfig: RegexConstant.none,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'help_mg0'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _titleInput(context, 'profile_mg14'.tr(context)),
          Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
          BasicTextField(
            controller: TextEditingController(),
            regexConfig: RegexConstant.none,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'help_mg1'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _titleInput(context, 'help_mg2'.tr(context)),
          Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
          BasicTextField(
            controller: TextEditingController(),
            regexConfig: RegexConstant.none,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            hintText: 'signup_mg1'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
          _titleInput(context, '${'help_mg3'.tr(context)} *'),
          Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
          BasicTextField(
            controller: TextEditingController(),
            regexConfig: RegexConstant.notEmpty,
            keyboardType: TextInputType.text,
            borderRadius: Dimens.dimens_12,
            maxLines: 4,
            minLines: 4,
            hintText: 'help_mg4'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        ],
      ),
    );
  }

  Text _titleInput(BuildContext context, String title) {
    final text = Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.regular,
      ),
    );
    return text;
  }

  ContainedButton _buildSubmitButton(BuildContext context) {
    return ContainedButton(
      title: 'sumbmit'.tr(context),
      size: const Size(double.infinity, Dimens.dimens_44),
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      onPress: _handleLogicSubmit,
    );
  }

  Future<void> _handleLogicSubmit() async {
    if (!_formSubmitHelp.currentState!.validate()) {
      return;
    }
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);
}
