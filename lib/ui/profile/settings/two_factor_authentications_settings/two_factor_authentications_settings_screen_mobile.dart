import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/ui/profile/settings/two_factor_authentications_settings/bloc/two_factor_authen_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../../constants/app_theme.dart';
import '../../../../constants/dimens.dart';
import '../../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../../widgets/divider/divider.dart';


class TwoFactorAuthenticationsSettingsScreenMobile extends StatelessWidget {
  const TwoFactorAuthenticationsSettingsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'two_factor_authentication'.tr(context)),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
            _title(context, 'settings_mg2'),
            Gap(ScreenUtil().setHeight(Dimens.dimens_25)),
            _switchActions(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_30)),
          ],
        ),
      ),
    );
  }

  Widget _switchActions(BuildContext context) {
    return BlocBuilder<TwoFactorAuthenBloc, TwoFactorAuthenState>(
      buildWhen: (previous, current) => current is TwoFactorAuthenTurnState && current != previous,
      builder: (context, state) {
        var turn = false;
        if (state is TwoFactorAuthenTurnState) {
          turn = state.turn;
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: _titleSwitch(context, 'off', !turn)),
            const Gap(Dimens.dimens_10),
            CupertinoSwitch(
              value: turn,
              activeColor: Theme.of(context).primaryColor,
              trackColor: Theme.of(context).colorScheme.surfaceTint,
              onChanged: (value) => _handleChangedSwitchTwoFactorAuthen(context, value),
            ),
            const Gap(Dimens.dimens_10),
            Flexible(child: _titleSwitch(context, 'on', turn)),
          ],
        );
      },
    );
  }

  void _handleChangedSwitchTwoFactorAuthen(BuildContext context, bool value) {
    BlocProvider.of<TwoFactorAuthenBloc>(context, listen: false).add(TwoFactorAuthenEvent.turned(turned: value));
  }

  Text _titleSwitch(BuildContext context, String title, bool action) {
    return Text(
      title.tr(context),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: action ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.surfaceTint,
        fontWeight: action ? AppThemeData.semiBold : AppThemeData.regular,
      ),
    );
  }

  Text _title(BuildContext context, String title) {
    return Text(
      title.tr(context),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: AppThemeData.regular,
      ),
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
