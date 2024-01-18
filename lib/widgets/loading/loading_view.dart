import 'package:flutter/material.dart';
import '../../constants/assets.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.icLoading,
        width: 70,
        fit: BoxFit.contain,
      ),
    );
  }
}
