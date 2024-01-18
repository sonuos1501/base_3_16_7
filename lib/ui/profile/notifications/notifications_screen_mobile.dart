// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../constants/dimens.dart';
import '../../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import '../../../widgets/bottom_sheet/item_bottomsheet_have_icon.dart';
import '../../../widgets/divider/divider.dart';
import '../../../widgets/image/cache_image.dart';


class NotificationsScreenMobile extends StatelessWidget {
  const NotificationsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: 'profile_mg1'.tr(context),
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
                itemCount: 100,
                padding: const EdgeInsets.only(bottom: Dimens.dimens_20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontal_padding,
                    ).copyWith(top: Dimens.dimens_20),
                    child: _itemNotifications(
                      context,
                      haveNoti: true,
                      title: 'Google uploaded: Searching for art just got better. Where will you start?',
                      time: DateTime.now(),
                      image: 'https://image.baophapluat.vn/1200x630/Uploaded/2023/gznrxgmabianhgzmath/2021_07_16/blackpink-rose5-4847.jpg',
                      onPress: () async {},
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

  Widget _itemNotifications(BuildContext context, {
    bool haveNoti = true,
    required String title,
    required DateTime time,
    required String image,
    required AsyncCallback onPress,
  }) {
    return CommonButton(
      onPress: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _dotCheckNoti(context, haveNoti),
          Gap(ScreenUtil().setWidth(Dimens.dimens_05)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(title, context),
                Gap(ScreenUtil().setHeight(Dimens.dimens_05)),
                _time(context, time),
              ],
            ),
          ),
          Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
          _image(image),
        ],
      ),
    );
  }

  Widget _image(String image) {
    return CacheImage(
      image: image,
      size: Size(ScreenUtil().setWidth(Dimens.dimens_130), ScreenUtil().setHeight(Dimens.dimens_70)),
    );
  }

  Widget _time(BuildContext context, DateTime time) {
    return Text(
      '${time.hour}:${time.minute}:${time.second}',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Text _title(String title, BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.medium,
      ),
    );
  }

  Widget _dotCheckNoti(BuildContext context, bool haveNoti) {
    const size = Dimens.dimens_05;
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.dimens_07),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: haveNoti ? Theme.of(context).colorScheme.outline : Colors.transparent,
          borderRadius: BorderRadius.circular(size / 2),
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
          ItemBottomSheetHaveIcon(icon: Assets.icDoubleDone, title: 'mark_all_as_read'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icTrashCan, title: 'remove_from_rented_videos'.tr(context), useDivider: false, onPress: () {}),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
