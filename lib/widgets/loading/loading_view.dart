import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.gif.icLoading.path,
        width: 70,
        fit: BoxFit.contain,
      ),
    );
  }
}
