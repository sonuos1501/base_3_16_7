import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class LogoTheShow extends StatelessWidget {
  const LogoTheShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Assets.logo.logoTheshowplayer.image();
  }
}
