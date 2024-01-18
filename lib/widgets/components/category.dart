import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/components/add_more_item.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.child,
    required this.titleLeft,
    this.titleRight,
    this.onTabAddMore,
    this.onTabTitleRight,
  });

  final Widget child;
  final String titleLeft;
  final String? titleRight;
  final AsyncCallback? onTabAddMore;
  final AsyncCallback? onTabTitleRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          child: _buildTitle(context, titleLeft: titleLeft, titleRight: titleRight),
        ),
        const Gap(Dimens.dimens_16),
        child,
        if (onTabAddMore != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          child: AddMoreItem(onPress: onTabAddMore!),
        )
      ],
    );
  }

  Widget _buildTitle(
    BuildContext context, {
    required String titleLeft,
    String? titleRight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleLeft,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surfaceVariant,fontWeight: AppThemeData.medium),
        ),
        CommonButton(
          onPress: onTabTitleRight,
          child: Text(
            titleRight ?? '',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onInverseSurface,fontWeight: FontWeight.w300,),
          ),
        ),
      ],
    );
  }
}
