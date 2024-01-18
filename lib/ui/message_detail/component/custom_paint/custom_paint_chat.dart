// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

class CustomPaintChat extends StatelessWidget {
  const CustomPaintChat({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        100,
        (100 * 0.25).toDouble(),
      ),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(size.width * 0.06929348, size.height * 0.3478261);
    path_0.cubicTo(
      size.width * 0.06929348,
      size.height * 0.1557270,
      size.width * 0.1082250,
      0,
      size.width * 0.1562500,
      0,
    );
    path_0.lineTo(size.width * 0.9130435, 0);
    path_0.cubicTo(
      size.width * 0.9610707,
      0,
      size.width,
      size.height * 0.1557270,
      size.width,
      size.height * 0.3478261,
    );
    path_0.lineTo(size.width, size.height * 0.6521739);
    path_0.cubicTo(
      size.width,
      size.height * 0.8442739,
      size.width * 0.9610707,
      size.height,
      size.width * 0.9130435,
      size.height,
    );
    path_0.lineTo(size.width * 0.8308424, size.height);
    path_0.lineTo(size.width * 0.5247652, size.height);
    path_0.lineTo(size.width * 0.2186880, size.height);
    path_0.lineTo(size.width * 0.1439908, size.height);
    path_0.lineTo(size.width * 0.007755761, size.height);
    path_0.cubicTo(
      size.width * 0.002321647,
      size.height,
      size.width * 0.0002515886,
      size.height * 0.9716239,
      size.width * 0.004832940,
      size.height * 0.9599326,
    );
    path_0.lineTo(size.width * 0.01654234, size.height * 0.9300543);
    path_0.cubicTo(
      size.width * 0.04940261,
      size.height * 0.8462087,
      size.width * 0.06929348,
      size.height * 0.7010804,
      size.width * 0.06929348,
      size.height * 0.5451739,
    );
    path_0.lineTo(size.width * 0.06929348, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.06929348, size.height * 0.3478261);
    path_0.close();

    final paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff393939).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
