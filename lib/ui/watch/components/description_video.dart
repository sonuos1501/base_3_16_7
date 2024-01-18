import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:theshowplayer/constants/app_text_styles.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/video_detail_model/video_detail_model.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';


class DescriptionVideo extends StatelessWidget {
  const DescriptionVideo({ super.key, required this.video });

  final VideoDetailModel video;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
          ).copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title ?? '',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.medium,
                  fontSize: AppTextStyles.fontSize_18,
                ),
              ),
              const Gap(Dimens.dimens_04),
              ReadMoreText(
                // '20 views $symbolDot 27/02/23 기ㅣ은지의 여름방학 기ㅣ은지의 여름방학',
                video.description ?? '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w300,
                  fontSize: AppTextStyles.fontSize_13,
                ),
                textDirection: TextDirection.ltr,
                trimLines: 1,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: ' less',
                moreStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: AppThemeData.semiBold,
                ),
                lessStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: AppThemeData.semiBold,
                ),
                callback: (val) {},
              ),
              const Gap(Dimens.dimens_24),
              Row(
                children: [
                  _buildBtn(
                    context,
                    onTap: () {},
                    pathIcon: Assets.icLikeSmall,
                    content: video.isLiked.toString(),
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  const Gap(Dimens.dimens_08),
                  _buildBtn(
                    context,
                    onTap: () {},
                    pathIcon: Assets.icDislikeSmall,
                  ),
                  const Gap(Dimens.dimens_08),
                  _buildBtn(
                    context,
                    onTap: () {},
                    pathIcon: Assets.icShare,
                  ),
                  const Gap(Dimens.dimens_08),
                  _buildBtn(
                    context,
                    onTap: () {},
                    pathIcon: Assets.icPlayList,
                  ),
                ],
              ),
              const Gap(Dimens.dimens_20),
              _buildInfoAccountChannel(context, video: video),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBtn(
    BuildContext context, {
    required void Function() onTap,
    String? content,
    required String pathIcon,
    Color? color,
    TextStyle? textStyle,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.dimens_07,
          horizontal: Dimens.dimens_18,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.surfaceTint),
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(pathIcon),
            if ((content ?? '').isNotEmpty) ...[
              const Gap(Dimens.dimens_10),
              Text(
                content ?? '',
                style: textStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.medium,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInfoAccountChannel(
    BuildContext context, {
    VideoDetailModel? video,
  }) {
    const size = Dimens.dimens_30;
    return Row(
      children: [
        CacheImage(
          image: video?.owner?.avatar ?? '',
          size: const Size(size, size),
          borderRadius: size / 2,
          imageBuilder: (context, imageProvider) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
          errorLoadingImage: Assets.icAvatarDefault,
        ),
        const Gap(Dimens.dimens_08),
        Text(
          video?.owner?.name ?? '',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.medium,
          ),
        ),
        const Gap(Dimens.dimens_08),
        Text(
          // video?.owner?.name ?? '',
          '',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
        _buildBtn(
          context,
          onTap: () {},
          pathIcon: Assets.icPlusSmall,
          content: 'subscribe'.tr(context),
          color: Theme.of(context).colorScheme.surfaceVariant,
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.background,
            fontWeight: AppThemeData.medium,
          ),
        )
      ],
    );
  }
}
