// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/ui/watch/components/body.dart';
import 'package:theshowplayer/ui/watch/components/comment.dart';
import 'package:theshowplayer/ui/watch/components/description_video.dart';
import 'package:theshowplayer/ui/watch/components/top_watch_screen.dart';
import 'package:theshowplayer/utils/bottom_sheet/BottomSheetUtil.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view_not_logo.dart';
import 'package:theshowplayer/widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import 'package:theshowplayer/widgets/bottom_sheet/item_bottomsheet_have_icon.dart';

import '../../models/video_detail_model/video_detail_model.dart';

class WatchScreenMobile extends StatelessWidget {
  const WatchScreenMobile({ super.key, required this.video });

  final VideoDetailModel video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: '',
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
        child: Column(
          children: [
            TopWatchScreen(videoLocation: video.videoLocation ?? ''),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DescriptionVideo(video: video),
                    const Gap(Dimens.dimens_14),
                    const Comment(),
                    const Body(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {}

  Future<void> _handleLogicNavigateToMenuSettings(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          ItemBottomSheetHaveIcon(
            icon: Assets.icShare,
            title: 'share'.tr(context),
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
