import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:html/dom.dart' as htmlParser;
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

class ItemMessage extends StatelessWidget {
  const ItemMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final symbolDot = htmlParser.DocumentFragment.html('&#8728;').text;

    return Row(
      children: [
        CacheImage(
          image: 'https://vcdn1-giaitri.vnecdn.net/2022/09/23/-2181-1663929656.jpg?w=680&h=0&q=100&dpr=2&fit=crop&s=3WlbCM6dawFQQ1O6KarrCA',
          size: const Size(50, 50),
          borderRadius: 25,
          errorLoadingImage: Assets.icAvatarDefault,
        ),
        const Gap(Dimens.dimens_08),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yuna',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.medium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Haha, that was just as Isadasdasda',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  _buildDot(context),
                  Text(
                    '12mins',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    width: Dimens.dimens_12,
                    height: Dimens.dimens_12,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

   Widget _buildDot(BuildContext context) {
    return Container(
      width: Dimens.dimens_04,
      height: Dimens.dimens_04,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color:Theme.of(context).colorScheme.onSurfaceVariant,),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.dimens_05),
    );
  }
}
