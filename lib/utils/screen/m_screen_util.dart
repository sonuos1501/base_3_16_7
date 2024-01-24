// ignore_for_file: avoid_multiple_declarations_per_line

import 'dart:developer';

import 'package:flutter/material.dart';

class MultipleScreenUtil extends StatelessWidget {
  const MultipleScreenUtil({
    super.key,
    required this.mobiles,
    required this.ipads,
    required this.desktops,
  });

  final Widget mobiles, ipads, desktops;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log('Max width: ${constraints.maxWidth}');
        if (constraints.maxWidth >= 1100) {
          return desktops;
        } else if (constraints.maxWidth >= 850) {
          return ipads;
        } else {
          return mobiles;
        }
      },
    );
  }
}
