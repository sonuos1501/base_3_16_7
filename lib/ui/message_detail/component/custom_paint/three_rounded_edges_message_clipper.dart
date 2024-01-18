// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

import '../../../../constants/enum/type_status_items.dart';

class ThreeRoundedEdgesMessageClipper extends CustomClipper<Path> {
  ThreeRoundedEdgesMessageClipper(this.type,
      {this.bubbleRadius = 30, this.fourthEdgeRadius = 2,});
  final MessageStatus type;
  final double bubbleRadius;
  final double fourthEdgeRadius;

  @override
  Path getClip(Size size) {
    final path = Path();

    if (type == MessageStatus.sent) {
      path.addRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          Radius.circular(bubbleRadius),
        ),
      );
      final path2 = Path();
      path2.addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          bubbleRadius,
          bubbleRadius,
          bottomRight: Radius.circular(fourthEdgeRadius),
        ),
      );
      path.addPath(
        path2,
        Offset(size.width - bubbleRadius, size.height - bubbleRadius),
      );
    } else {
      path.addRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          Radius.circular(bubbleRadius),
        ),
      );
      final path2 = Path();
      path2.addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          bubbleRadius,
          bubbleRadius,
          bottomLeft: Radius.circular(fourthEdgeRadius),
        ),
      );
      path.addPath(path2, const Offset(0, 0));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
