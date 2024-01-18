
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../constants/dimens.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/divider/divider.dart';


class SettingsScreenMobile extends StatelessWidget {
  const SettingsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: 'profile_mg7'.tr(context),
        actions: [
          ButtonIconAction(icon: Assets.icSearch, onTab: _handleLogicNavigateToSearch),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _divider(context),
            Expanded(child: _buildOptionsSettings(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSettings(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
          _itemOptionsSettings(
            context,
            icon: Assets.icPassword,
            title: 'password',
            onPress: _handleLogicNavigateToPasswordSettingsScreen,
          ),
          _itemOptionsSettings(
            context,
            icon: Assets.icTwoFactorAuthentications,
            title: 'two_factor_authentication',
            onPress: _handleLogicNavigateToTwoFactorAuthenSettingsScreen,
          ),
          _itemOptionsSettings(
            context,
            icon: Assets.icLanguages,
            title: 'languages',
            onPress: _handleLogicNavigateToLanguagesSettingsScreen,
          ),
          _itemOptionsSettings(
            context,
            icon: Assets.icBlockUseInSettings,
            title: 'blocked_users',
            onPress: _handleLogicNavigateToBlockUserSettingsScreen,
          ),
          _itemOptionsSettings(
            context,
            icon: Assets.icTrashCan,
            title: 'delete_account',
            onPress: _handleLogicNavigateToDeleteAccountSettingsScreen,
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToDeleteAccountSettingsScreen() async => navigation.navigateTo(RouterName.deleteAccountSettings);

  Future<void> _handleLogicNavigateToBlockUserSettingsScreen() async => navigation.navigateTo(RouterName.blockUsersSettings);

  Future<void> _handleLogicNavigateToLanguagesSettingsScreen() async => navigation.navigateTo(RouterName.languagesSettings);

  Future<void> _handleLogicNavigateToTwoFactorAuthenSettingsScreen() async => navigation.navigateTo(RouterName.twoFactorAuthenticationsSettings);

  Future<void> _handleLogicNavigateToPasswordSettingsScreen() async => navigation.navigateTo(RouterName.passwordSettings);

  Widget _itemOptionsSettings(
    BuildContext context, {
    required String icon,
    required String title,
    required AsyncCallback onPress,
  }) {
    return CommonButton(
      onPress: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.dimens_20),
        child: Row(
          children: [
            _icon(context, icon),
            Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
            Expanded(child: _title(context, title)),
          ],
        ),
      ),
    );
  }

  Widget _icon(BuildContext context, String icon) {
    return SvgPicture.asset(icon, height: Dimens.dimens_20, color: Theme.of(context).colorScheme.surfaceVariant);
  }

  Widget _title(BuildContext context, String title) {
    return Text(
      title.tr(context),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.regular,
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
