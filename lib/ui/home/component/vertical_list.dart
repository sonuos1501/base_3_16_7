import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/widgets/components/category.dart';
import 'package:theshowplayer/widgets/components/video_items.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    super.key,
    required this.titleLeft,
    required this.data,
    this.onTabAddMore,
  });
  final String titleLeft;
  final List<VideoItems> data;
  final AsyncCallback? onTabAddMore;

  @override
  Widget build(BuildContext context) {
    return CategoryItems(
      titleLeft: titleLeft,
      onTabAddMore: onTabAddMore,
      child: _buildChildLatestVideo(),
    );
  }

  Widget _buildChildLatestVideo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        data.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding,).copyWith(bottom: Dimens.dimens_24),
            child: data[index],
          );
        },
      ),
    );
  }
}
