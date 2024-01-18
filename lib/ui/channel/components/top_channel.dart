// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../widgets/image/cache_image.dart';

class TopChannels extends StatelessWidget {
  const TopChannels({
    super.key,
    required this.avatar,
    required this.name,
    required this.topNumber,
    required this.onPress,
    this.views,
    this.followers,
  });

  final String avatar, name;
  final int topNumber;
  final String? views, followers;
  final AsyncCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_02, vertical: Dimens.dimens_05),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).colorScheme.surfaceTint),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimens.dimens_08), topRight: Radius.circular(Dimens.dimens_08)),
          image: DecorationImage(
            image: AssetImage('assets/images/background_top$topNumber.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
            _avatar(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
            _name(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
            _views(context),
            Gap(ScreenUtil().setHeight(Dimens.dimens_03)),
            _followers(context),
            Gap(ScreenUtil().setWidth(topNumber == 1 ? Dimens.dimens_25 : Dimens.dimens_10)),
          ],
        ),
      ),
    );
  }

  Widget _followers(BuildContext context) {
    return _titleIntroduce(context, icon: Assets.icPlus, title: '${followers ?? 0} ${'followers'.tr(context).toLowerCase()}');
  }

  Widget _views(BuildContext context) {
    return _titleIntroduce(context, icon: Assets.icEge, title: '${views ?? 0} ${'views'.tr(context)}');
  }

  Widget _titleIntroduce(BuildContext context, { required String icon, required String title }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, height: Dimens.dimens_15),
        Gap(ScreenUtil().setWidth(Dimens.dimens_03)),
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: AppThemeData.regular,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Text _name(BuildContext context) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    final size = ScreenUtil().setWidth(Dimens.dimens_75);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(height: size + Dimens.dimens_13, color: Colors.transparent),
        CacheImage(
          image: avatar,
          size: Size(size, size),
          borderRadius: size / 2,
          imageBuilder: (context, imageProvider) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
          errorLoadingImage: Assets.icAvatarDefault,
        ),
        if (topNumber == 1) Positioned(top: 0, child: SvgPicture.asset(Assets.icPremium)),
      ],
    );
  }

}
