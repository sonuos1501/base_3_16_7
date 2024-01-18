import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';

class MenuNav extends StatefulWidget {
  const MenuNav({
    super.key,
    required this.menuList,
    this.indexSelected = 0,
    this.onTapItem,
    this.openDraw,
  });

  final List<String> menuList;
  final int indexSelected;
  final ValueChanged<int>? onTapItem;
  final void Function()? openDraw;

  @override
  State<MenuNav> createState() => _MenuNavState();
}

class _MenuNavState extends State<MenuNav> {
  late AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.scrollToIndex(
      widget.indexSelected - 1,
      preferPosition: AutoScrollPosition.begin,
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8).copyWith(left: 20),
      height: 44,
      child: Row(
        children: [
          InkWell(
            onTap: widget.openDraw,
            child: SvgPicture.asset(Assets.icMenuTop),
          ),
          Gap(ScreenUtil().setWidth(5)),
          VerticalDivider(
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: widget.menuList.length,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  controller: _controller,
                  index: index,
                  key: ValueKey(index),
                  child: _itemMenu(
                    context,
                    title: widget.menuList[index],
                    isSelected: widget.indexSelected == index,
                    index: index,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _itemMenu(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        if (widget.onTapItem != null) {
          widget.onTapItem!(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
              ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          borderRadius: BorderRadius.circular(11),
          color: isSelected
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : null,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: isSelected
              ? Theme.of(context).colorScheme.surfaceVariant
              : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? AppThemeData.semiBold : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
