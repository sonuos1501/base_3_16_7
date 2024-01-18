// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/dimens.dart';
import '../../widgets/components/logo_theshow.dart';

class SuccessFailScreenMobile extends StatelessWidget {
  const SuccessFailScreenMobile({
    super.key,
    required this.imageBackground,
    required this.titleNoti,
    required this.contentNoti,
    this.actions,
  });

  final String imageBackground;
  final String titleNoti, contentNoti;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(ScreenUtil().setHeight(Dimens.dimens_50)),
                const LogoTheShow(),
                Gap(ScreenUtil().setHeight(Dimens.dimens_60)),
                _buildImage(),
                Gap(ScreenUtil().setHeight(Dimens.dimens_25)),
                _buildNotification(context),
                Gap(ScreenUtil().setHeight(Dimens.dimens_40)),
                if (actions != null) ...[
                  actions!,
                  Gap(ScreenUtil().setHeight(Dimens.dimens_32)),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotification(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titleNoti.tr(context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.medium,
          ),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
        Text(
          contentNoti.tr(context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.regular,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Image.asset(imageBackground, height: ScreenUtil().setHeight(Dimens.dimens_132), fit: BoxFit.fill);
  }

}
