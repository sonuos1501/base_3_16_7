

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theshowplayer/constants/dimens.dart';

import '../divider/divider.dart';

class BottomSheetStrikeThrough extends StatelessWidget {
  const BottomSheetStrikeThrough({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _divider(context),
        Container(
          // padding: const EdgeInsets.only(bottom: Dimens.dimens_25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceTint,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimens.dimens_16), topRight: Radius.circular(Dimens.dimens_16)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: Dimens.dimens_10),
    child: CustomDivider(
      height: Dimens.dimens_03,
      width: ScreenUtil().setWidth(Dimens.dimens_140),
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: Dimens.dimens_100,
    ),
  );
}
