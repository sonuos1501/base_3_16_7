// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
  });

  final Color? color;
  final double? height, width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius == null ? null : BorderRadius.circular(borderRadius!),
      ),
    );
  }
}
