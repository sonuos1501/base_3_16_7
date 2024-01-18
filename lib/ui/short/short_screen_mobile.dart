// ignore_for_file: inference_failure_on_function_invocation
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/ui/short/component/item_short.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/empty_box/empty_box.dart';
import 'package:video_player/video_player.dart';

import '../../models/channels/short_data.dart';
import '../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../../widgets/appbar/appbar_view_not_logo.dart';
import '../../widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import '../../widgets/bottom_sheet/item_bottomsheet_have_icon.dart';
import '../../widgets/button/cs_icon_button.dart';

class ShortScreenMobile extends StatefulWidget {
  const ShortScreenMobile({
    super.key,
    required this.listShort,
    required this.index,
    this.videoPlayerController,
  });
  final void Function(VideoPlayerController videoPlayerController)? videoPlayerController;

  final List<ShortData> listShort;
  final int index;

  @override
  State<ShortScreenMobile> createState() => _ShortScreenMobileState();
}

class _ShortScreenMobileState extends State<ShortScreenMobile> {
  VideoPlayerController? _videoPlayerController;
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToPage(widget.index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.listShort.isEmpty
        ? EmptyBox(title: 'no_element'.tr(context).toUpperCase())
        : Stack(
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              controller: _controller,
              children: widget.listShort
                .map((e) => ItemShort(
                  shortData: e,
                  videoPlayerController: (chewieController) {
                    _videoPlayerController = chewieController;
                    if (widget.videoPlayerController != null) {
                      widget.videoPlayerController!(chewieController);
                    }
                  },
                ),)
                .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(top: Dimens.dimens_70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Navigator.canPop(context))
                    CsIconButton(
                      image: Assets.icArrowBack,
                      height: Dimens.dimens_13,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      onPress: () async => navigation.pop(),
                    ),
                  const Spacer(),
                  ButtonIconAction(icon: Assets.icSearch, onTab: _handleLogicNavigateToSearch),
                  ButtonIconAction(icon: Assets.icMenuSettings, onTab: () => _handleLogicNavigateToMenuSettings(context)),
                ],
              ),
            ),
          ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToMenuSettings(BuildContext context) async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          ItemBottomSheetHaveIcon(icon: Assets.icBlock, title: 'block_user'.tr(context), onPress: () {}),
          ItemBottomSheetHaveIcon(icon: Assets.icReportUser, title: 'report_user'.tr(context), useDivider: false, onPress: () {}),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToSearch() async {
    await navigation.navigateTo(RouterName.search);
  }

}
