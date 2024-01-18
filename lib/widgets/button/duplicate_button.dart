// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_outline_button.dart';
import 'contained_button.dart';

class DuplicateButton extends StatelessWidget {
  const DuplicateButton({
    super.key,
    required this.titleLeft,
    required this.titleRight,
    this.functionLeft,
    this.functionRight,
    this.radius,
    this.size,
  });

  final String titleLeft, titleRight;
  final double? radius;
  final Size? size;
  final AsyncCallback? functionLeft, functionRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseOutlineButton(
            backgroundColor: Colors.transparent,
            size: size,
            title: titleLeft,
            onPress: functionLeft,
            borderRadius: radius,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ContainedButton(
            title: titleRight,
            onPress: functionRight,
            borderRadius: radius,
            size: size,
          ),
        ),
      ],
    );
  }
}
