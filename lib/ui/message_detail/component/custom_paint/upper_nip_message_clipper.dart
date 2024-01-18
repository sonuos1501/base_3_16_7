// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

import '../../../../constants/enum/type_status_items.dart';

class UpperNipMessageClipper extends CustomClipper<Path> {
  UpperNipMessageClipper(
    this.type, {
    this.bubbleRadius = 16,
    this.sizeOfNip = 8,
    this.sizeRatio = 4,
  });
  final MessageStatus type;
  final double bubbleRadius;
  final double sizeOfNip;
  final double sizeRatio;

  @override
  Path getClip(Size size) {
    final path = Path();

    if (type == MessageStatus.sent) {
      path.moveTo(bubbleRadius, sizeOfNip);
      path.lineTo(size.width - sizeOfNip * sizeRatio, sizeOfNip);

      path.quadraticBezierTo(size.width - sizeOfNip, sizeOfNip, size.width, 0);
      path.quadraticBezierTo(
        size.width - sizeOfNip,
        sizeOfNip,
        size.width - sizeOfNip,
        sizeRatio * sizeOfNip,
      );

      path.lineTo(size.width - sizeOfNip, size.height - bubbleRadius);
      path.arcToPoint(
        Offset(size.width - sizeOfNip - bubbleRadius, size.height),
        radius: Radius.circular(bubbleRadius),
      );
      path.lineTo(bubbleRadius, size.height);
      path.arcToPoint(
        Offset(0, size.height - bubbleRadius),
        radius: Radius.circular(bubbleRadius),
      );
      path.lineTo(0, bubbleRadius + sizeOfNip);
      path.arcToPoint(
        Offset(bubbleRadius, sizeOfNip),
        radius: Radius.circular(bubbleRadius),
      );
    } else {
      path.quadraticBezierTo(
        sizeOfNip,
        sizeOfNip,
        sizeRatio * sizeOfNip,
        sizeOfNip,
      );
      path.lineTo(size.width - bubbleRadius, sizeOfNip);
      path.arcToPoint(
        Offset(size.width, sizeOfNip + bubbleRadius),
        radius: Radius.circular(bubbleRadius),
      );
      path.lineTo(size.width, size.height - bubbleRadius);
      path.arcToPoint(
        Offset(size.width - bubbleRadius, size.height),
        radius: Radius.circular(bubbleRadius),
      );
      path.lineTo(sizeOfNip + bubbleRadius, size.height);
      path.arcToPoint(
        Offset(sizeOfNip, size.height - bubbleRadius),
        radius: Radius.circular(bubbleRadius),
      );
      path.lineTo(sizeOfNip, sizeRatio * sizeOfNip);
      path.quadraticBezierTo(sizeOfNip, sizeOfNip, 0, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
