// ignore_for_file: avoid_multiple_declarations_per_line


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/enum/type_status_items.dart';
import '../../utils/utils.dart';
import '../button/cs_icon_button.dart';
import 'tags_status.dart';

class InfoLivesChannels {
  const InfoLivesChannels({
    this.numVideos,
    this.numViews,
    this.title,
    this.numMins,
  });

  final String? numVideos, numViews, numMins, title;
}

class LiveAndChannelItems extends StatelessWidget {
  const LiveAndChannelItems({
    super.key,
    required this.imageBackground,
    required this.avatar,
    required this.name,
    required this.onPress,
    required this.size,
    required this.listTypeStatusItems,
    this.onPressSettings,
    this.infoLivesChannels,
    this.gradient,
  });

  final String imageBackground, avatar, name;
  final Size size;
  final List<TypeStatusItems> listTypeStatusItems;
  final AsyncCallback onPress;
  final InfoLivesChannels? infoLivesChannels;
  final AsyncCallback? onPressSettings;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CacheImage(
                  image: imageBackground,
                  size: size,
                  borderRadius: Dimens.dimens_12,
                ),
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.dimens_08),
                    gradient: gradient ?? LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.2, 0.72],
                      colors: [
                        AppColors.black1D1313.withOpacity(0.6),
                        AppColors.black1B1313.withOpacity(0.52),
                        AppColors.black121212.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: Dimens.dimens_08,
                  right: Dimens.dimens_08,
                  child: _buildTagsStatus(context),
                ),
                Positioned.fill(
                  left: Dimens.dimens_12,
                  bottom: Dimens.dimens_12,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: _buildInfoPerson(context),
                  ),
                ),
              ],
            ),
            if (infoLivesChannels != null) ...[
              const Gap(Dimens.dimens_10),
              _buildInfoLiveChannels(context),
              if ((infoLivesChannels?.title ?? '').isNotEmpty) ...[
                const Gap(Dimens.dimens_10),
                _buildTitleLive(context),
              ]
            ]
          ],
        ),
      ),
    );
  }

  Text _buildTitleLive(BuildContext context) {
    return Text(
      infoLivesChannels?.title ?? '',
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: AppThemeData.semiBold,color: Theme.of(context).colorScheme.surfaceVariant),
    );
  }

  Row _buildInfoLiveChannels(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: _buildTitleInfo(
                  context,
                  (infoLivesChannels?.title ?? '').isNotEmpty
                    ? '${Utils.getUnitName(double.parse((infoLivesChannels?.numMins ?? 0).toString().replaceAll(',', '')))} ${'mins'.tr(context).toLowerCase()}'
                    : '${Utils.getUnitName(double.parse((infoLivesChannels?.numVideos ?? 0).toString().replaceAll(',', '')))} ${'videos'.tr(context).toLowerCase()}',
                ),
              ),
              const Gap(Dimens.dimens_05),
              SvgPicture.asset(Assets.icDot),
              const Gap(Dimens.dimens_05),
              Flexible(child: _buildTitleInfo(context,'${Utils.getUnitName(double.parse((infoLivesChannels?.numViews ?? 0).toString().replaceAll(',', '')))} ${'views'.tr(context)}')),
            ],
          ),
        ),
        if ((infoLivesChannels?.title ?? '').isNotEmpty)
          _buildSettings(Theme.of(context).colorScheme.onTertiaryContainer),
      ],
    );
  }

  CsIconButton _buildSettings(Color color) {
    return CsIconButton(
      image: Assets.icMenuSettings,
      height: Dimens.dimens_15,
      padding: const EdgeInsets.only(right: Dimens.dimens_12, left: Dimens.dimens_05),
      color: color,
      onPress: onPressSettings ?? () async {},
    );
  }

  Text _buildTitleInfo(BuildContext context, String titleInfo) {
    return Text(
      titleInfo,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: AppThemeData.regular,color: Theme.of(context).colorScheme.onTertiaryContainer),
    );
  }

  Widget _buildInfoPerson(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(),
        const Gap(Dimens.dimens_05),
        Expanded(child: _buildNameOfPerson(context)),
      ],
    );
  }

  Text _buildNameOfPerson(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: AppThemeData.regular,color: Theme.of(context).colorScheme.surfaceVariant),
    );
  }

  CacheImage _buildAvatar() {
    const size = Dimens.dimens_28;
    return CacheImage(
      image: avatar,
      size: const Size(size, size),
      borderRadius: size / 2,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Widget _buildTagsStatus(BuildContext context) {
    return Row(
      children: List.generate(
        listTypeStatusItems.length,
        (index) => Padding(
          padding: EdgeInsets.only(left: index > 0 ? Dimens.dimens_05 : 0),
          child: TagStatus(
            title: listTypeStatusItems[index].text(context),
            backgroundColor: listTypeStatusItems[index].color(context),
          ),
        ),
      ),
    );
  }
}
