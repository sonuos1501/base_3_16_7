import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'common_button.dart';

class CsIconButton extends StatelessWidget {
  const CsIconButton({
    super.key,
    required this.image,
    required this.onPress,
    this.height,
    this.color,
    this.padding,
  });

  final String image;
  final AsyncCallback onPress;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Container(
        padding: padding,
        color: Colors.transparent,
        child: SvgPicture.asset(
          image,
          alignment: Alignment.centerRight,
          color: color,
          height: height ?? 24,
        ),
      ),
    );
  }
}
