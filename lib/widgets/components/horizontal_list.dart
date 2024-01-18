import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theshowplayer/constants/dimens.dart';

import 'category.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    super.key,
    required this.titleLeft,
    this.titleRight,
    required this.data,
    this.height = Dimens.dimens_172,
    this.onTabTitleRight,
  });
  final String titleLeft;
  final String? titleRight;
  final List<Widget> data;
  final double height;
  final AsyncCallback? onTabTitleRight;

  @override
  Widget build(BuildContext context) {
    return CategoryItems(
      titleLeft: titleLeft,
      titleRight: titleRight,
      onTabTitleRight: onTabTitleRight,
      child: _buildChildDiscovery(),
    );
  }

  Widget _buildChildDiscovery() {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == data.length - 1 ? Dimens.horizontal_padding : 8,
              left: index == 0 ? Dimens.horizontal_padding : 0,
            ),
            child: data[index],
          );
        },
      ),
    );
  }
}
