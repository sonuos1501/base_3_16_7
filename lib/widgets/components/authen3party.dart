// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';
import '../../gen/assets.gen.dart';
import '../button/cs_icon_button.dart';
import '../divider/divider.dart';

class Authen3Party extends StatelessWidget {
  const Authen3Party({
    super.key,
    required this.title,
    required this.onPressGoogle,
    required this.onPressKaKaoTalk,
    required this.onPressNaver,
  });

  final String title;
  final AsyncCallback onPressGoogle, onPressKaKaoTalk, onPressNaver;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 1, child: _buildTitle(context, size)),
        Expanded(
          flex: 1,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            alignment: Alignment.center,
            child: _buildType3Party(size),
          ),
        ),
      ],
    );
  }

  Widget _buildType3Party(Size size) {
    final sizeIcon = ScreenUtil().setWidth(Dimens.dimens_50);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CsIconButton(
            image: Assets.icons.icGoogle.path,
            height: sizeIcon,
            onPress: onPressGoogle,
          ),
        ),
        const Gap(20),
        Expanded(
          child: CsIconButton(
            image: Assets.icons.icKakaotalk.path,
            height: sizeIcon,
            onPress: onPressKaKaoTalk,
          ),
        ),
        const Gap(20),
        Expanded(
          child: CsIconButton(
            image: Assets.icons.icNaver.path,
            height: sizeIcon,
            onPress: onPressNaver,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, Size size) {
    final padBetweenElem = ScreenUtil().setHeight(Dimens.dimens_16);

    return Row(
      children: [
        _divider(context),
        Gap(padBetweenElem),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: AppThemeData.medium,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
        ),
        Gap(padBetweenElem),
        _divider(context),
      ],
    );
  }

  Expanded _divider(BuildContext context) => Expanded(
        child: CustomDivider(color: Theme.of(context).colorScheme.surfaceTint),
      );
}
