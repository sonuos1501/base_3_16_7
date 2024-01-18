import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/video_detail_model/video_detail_model.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/utils.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../../configs/routers/router_name.dart';
import '../../../di/action_method_locator.dart';
import '../../../models/home/categories_data.dart';

class HotVideo extends StatelessWidget {
  const HotVideo({
    super.key,
    required this.videoDetail,
    required this.categories,
  });

  final VideoDetailModel videoDetail;
  final List<DetailCategory> categories;

  @override
  Widget build(BuildContext context) {
    final category = categories.firstWhere(
      (element) => element.id.toString().toLowerCase() == videoDetail.categoryId.toString().toLowerCase(),
      orElse: DetailCategory.new,
    ).description ?? '';

    return Column(
      children: [
        SizedBox(
          height: Dimens.dimens_252,
          child: Stack(
            children: [
              CacheImage(image: videoDetail.thumbnail ?? '', size: const Size(double.infinity, 252)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 0.3328, 0.6375],
                    colors: [
                      AppColors.black1E1919,
                      AppColors.black131010.withOpacity(0.64),
                      AppColors.black504B4B.withOpacity(0),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icHotVideo),
                        const Gap(Dimens.dimens_08),
                        Text(
                          'hot_video'.tr(context),
                          style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surfaceVariant,fontWeight: AppThemeData.semiBold,),
                        )
                      ],
                    ),
                    const Gap(Dimens.dimens_08),
                    Text(
                      videoDetail.title ?? '',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surfaceVariant,fontWeight: AppThemeData.bold,),
                    ),
                    const Gap(Dimens.dimens_08),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(top: Dimens.dimens_16),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      DateTimeUtil.getDateTimeStamp(
                        videoDetail.time ?? DateTime.now().millisecondsSinceEpoch,
                      ) ?? DateTimeUtil.getDateTimeToDate(DateTime.now()) ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    _buildDot(context),
                    Flexible(
                      child: Text(
                        category,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    if (category.isNotEmpty) _buildDot(context),
                    Text(
                      videoDetail.duration ?? '00:00:00',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Dimens.dimens_05),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    await navigation.navigateTo(RouterName.watchScreen, arguments: videoDetail);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_16, vertical: Dimens.dimens_10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      borderRadius: BorderRadius.circular(Dimens.dimens_12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.icPlay),
                        const Gap(Dimens.dimens_09),
                        Text(
                          'play'.tr(context),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            fontWeight:AppThemeData.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(BuildContext context) {
    return Container(
      width: Dimens.dimens_05,
      height: Dimens.dimens_05,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color:Theme.of(context).colorScheme.onSurfaceVariant,),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.dimens_05),
    );
  }
}
