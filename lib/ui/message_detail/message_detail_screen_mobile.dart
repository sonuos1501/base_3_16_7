import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_text_styles.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/ui/message_detail/component/content_message/content_message.dart';
import 'package:theshowplayer/ui/message_detail/component/input_message/input_message.dart';
import 'package:theshowplayer/utils/bottom_sheet/BottomSheetUtil.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view_not_logo.dart';
import 'package:theshowplayer/widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../constants/app_theme.dart';
import '../../widgets/bottom_sheet/item_bottomsheet_have_icon.dart';

class MessageDetailScreenMobile extends StatelessWidget {
  const MessageDetailScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: '',
        titleCustom: _customTitleAppBar(context),
        actions: [
          ButtonIconAction(
            icon: Assets.icSearch,
            onTab: _handleLogicNavigateToSearch,
          ),
          ButtonIconAction(
            icon: Assets.icMenuSettings,
            onTab: () => _handleLogicNavigateToMenuSettings(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.dimens_12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(
                child: ContentMessage(),
              ),
              InputMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTitleAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CacheImage(
          image: 'https://vcdn1-giaitri.vnecdn.net/2022/09/23/-2181-1663929656.jpg?w=680&h=0&q=100&dpr=2&fit=crop&s=3WlbCM6dawFQQ1O6KarrCA',
          size: const Size(30, 30),
          borderRadius: 15,
          errorLoadingImage: Assets.icAvatarDefault,
        ),
        const Gap(Dimens.dimens_08),
        Text(
          'Yuna',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: AppThemeData.medium,
          ),
        ),
        const Gap(Dimens.dimens_10),
        Container(
          height: Dimens.dimens_06,
          width: Dimens.dimens_06,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const Gap(Dimens.dimens_04),
        Text(
          'Online',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.surfaceVariant,
            fontWeight: FontWeight.w300,
            fontSize: AppTextStyles.fontSize_13,
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_16),
    child: CustomDivider(
      height: 1,
      color: Theme.of(context).colorScheme.surfaceTint,
    ),
  );

  Future<void> _handleLogicNavigateToSearch() async {}

  Future<void> _handleLogicNavigateToMenuSettings(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          ItemBottomSheetHaveIcon(
            icon: Assets.icReportUser,
            title: 'delete_message'.tr(context),
            useDivider: false,
            onPress: () {},
          ),
          ItemBottomSheetHaveIcon(
            icon: Assets.icBlock,
            title: 'block_user'.tr(context),
            onPress: () {},
          ),
          ItemBottomSheetHaveIcon(
            icon: Assets.icReportUser,
            title: 'report_user'.tr(context),
            useDivider: false,
            onPress: () {},
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }
}

class ContainerToClip extends StatelessWidget {
  const ContainerToClip(this.color, this.text, {super.key});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
      maxWidth: 250,
      minWidth: 50,
    ),
      padding: const EdgeInsets.only(left: 15, right: 10, bottom: 15, top: 5),
      color: color,
      child: Text(
        text,
        maxLines: 5,
        textWidthBasis: TextWidthBasis.parent,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
