
// ignore_for_file: cast_nullable_to_non_nullable, use_named_constants, avoid_multiple_declarations_per_line



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';

import '../../constants/dimens.dart';
import '../button/common_button.dart';
import '../divider/divider.dart';
class TabView extends StatefulWidget {

  const TabView({
    super.key,
    this.header,
    required this.titles,
    required this.bodies,
  });

  final Widget? header;
  final List<String> titles;
  final List<Widget> bodies;

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {

  int _indexSeleted = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    if (mounted) {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    const heightTab = Dimens.dimens_50;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (widget.header != null) SliverToBoxAdapter(child: widget.header),
        SliverPersistentHeader(
          pinned: true,
          delegate: PersistentHeader(
            maxExt: heightTab,
            minExt: heightTab,
            widget: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _divider(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
                  child: Row(
                    children: List.generate(
                      widget.titles.length,
                      (index) => _itemTab(index, widget.titles[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.dimens_20),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return PageStorage(bucket: bucket, child: widget.bodies[_indexSeleted]);
  }

  Widget _itemTab(int index, String title) {
    final selected = _indexSeleted == index;

    return Flexible(
      child: CommonButton(
        onPress: () async {
          setState(() {
            _indexSeleted = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: selected ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: AppThemeData.medium,
              ),
            ),
            const Gap(Dimens.dimens_10),
            _divider(context, color: selected ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.surfaceTint)
          ],
        ),
      ),
    );
  }

  CustomDivider _divider(BuildContext context, { Color? color }) => CustomDivider(height: 1, color: color ?? Theme.of(context).colorScheme.surfaceTint);

}

class PersistentHeader extends SliverPersistentHeaderDelegate {

  PersistentHeader({
    required this.widget,
    required this.maxExt,
    required this.minExt,
    this.backgroundColor,
  });

  final Widget widget;
  final double maxExt, minExt;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent,) {
    return Container(
      width: double.infinity,
      height: maxExt,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => maxExt;

  @override
  double get minExtent => minExt;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
