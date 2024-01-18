
// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../constants/assets.dart';
import '../../constants/dimens.dart';
import '../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../components/type_share.dart';
import 'bottom_sheet_strikethrough.dart';

abstract class BottomSheetShare {

  static Future<void> handleLogicActionsShare(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(
          bottom: Dimens.dimens_25,
          top: Dimens.dimens_16,
        ),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap(ScreenUtil().setHeight(Dimens.dimens_10)),
          TitleShare(context: context),
          Gap(ScreenUtil().setHeight(Dimens.dimens_15)),
          SizedBox(
            height: Dimens.dimens_80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Gap(ScreenUtil().setHeight(Dimens.horizontal_padding)),
                TypeShare(context: context, icon: Assets.icCopyLink, title: 'copy_link', onPress: () async {}),
                Gap(ScreenUtil().setHeight(Dimens.dimens_18)),
                TypeShare(context: context, icon: Assets.icKaKaoTalk, title: 'kakao_talk', onPress: () async {}),
                Gap(ScreenUtil().setHeight(Dimens.dimens_18)),
                TypeShare(context: context, icon: Assets.icNaver, title: 'naver', onPress: () async {}),
                Gap(ScreenUtil().setHeight(Dimens.dimens_18)),
                TypeShare(context: context, icon: Assets.icFacebook, title: 'facebook', onPress: () async {}),
                Gap(ScreenUtil().setHeight(Dimens.dimens_18)),
                TypeShare(context: context, icon: Assets.icTwitter, title: 'twitter', onPress: () async {}),
                Gap(ScreenUtil().setHeight(Dimens.horizontal_padding)),
              ],
            ),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

}
