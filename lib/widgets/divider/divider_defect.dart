import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Extends/ColorExtends.dart';
import 'dot_separator.dart';

class DividerDefect extends StatelessWidget {
  const DividerDefect({ super.key });

  @override
  Widget build(BuildContext context) {
    return _dividerDefect();
  }

  Row _dividerDefect() {
    return Row(
      children: [
        _svg('ic_haflt_circel_left'),
        Expanded(
            child: DotSeparator(
          color: ColorExtends('E0E0E0'),
        ),),
        _svg('ic_haflt_circel_right')
      ],
    );
  }

  SvgPicture _svg(String icon) {
    return SvgPicture.asset(
      icon,
      color: ColorExtends('ECEAEA'),
    );
  }
}
