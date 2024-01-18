// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../../constants/assets.dart';
import '../../../constants/dimens.dart';
import '../../../constants/enum/type_status_items.dart';
import '../../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import '../../../widgets/bottom_sheet/item_bottomsheet_have_icon.dart';
import '../../../widgets/components/video_items.dart';
import '../../../widgets/divider/divider.dart';


class RentedVideosScreenMobile extends StatelessWidget {
  const RentedVideosScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: 'profile_mg5'.tr(context),
        actions: [
          ButtonIconAction(icon: Assets.icSearch, onTab: _handleLogicNavigateToSearch),
          ButtonIconAction(icon: Assets.icMenuSettings, onTab: () async => _handleLogicNavigateToMenuSettings(context)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _divider(context),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontal_padding,
                    ).copyWith(top: Dimens.dimens_20),
                    child: VideoItems(
                      imageBackground: 'https://images.lifestyleasia.com/wp-content/uploads/sites/5/2022/08/01134813/BLACKPINK-1-1600x898.jpeg',
                      avatar: 'https://image.baophapluat.vn/1200x630/Uploaded/2023/gznrxgmabianhgzmath/2021_07_16/blackpink-rose5-4847.jpg',
                      name: 'Rose',
                      time: '00:00:00',
                      title: 'Sexy black bikini kasama ang Korean girl [4K UHD]',
                      onPressSettings: () async {},
                      onPress: () async {},
                      numberView: 100,
                      isPremium: true,
                      listTypeStatusItems: const [TypeStatusItems.sale],
                      money: 26.99,
                      numberSolds: 6,
                      saleMoney: 16.99,
                    ),
                  );
                },
              ),
            ),
            const Gap(Dimens.dimens_10),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogicNavigateToMenuSettings(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          ItemBottomSheetHaveIcon(icon: Assets.icShare, title: 'share'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icBlock, title: 'block_user'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icTrashCan, title: 'remove_from_rented_videos'.tr(context), useDivider: false, onPress: () {}),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
