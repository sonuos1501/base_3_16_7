// ignore_for_file: inference_failure_on_function_invocation
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/short/arguments_like_dislike.dart';
import 'package:theshowplayer/ui/short/bloc/short_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/button/cs_icon_button.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/colors.dart';
import '../../../models/channels/short_data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/bottom_sheet/bottom_sheet_share.dart';
import '../../video_preview/video_adapter_screen.dart';
import '../../video_preview/video_preview_screen.dart';

class ItemShort extends StatefulWidget {
  const ItemShort({ super.key, required this.shortData, this.videoPlayerController });

  final void Function(VideoPlayerController videoPlayerController)? videoPlayerController;
  final ShortData shortData;

  @override
  State<ItemShort> createState() => _ItemShortState();
}

class _ItemShortState extends State<ItemShort> {
  late final _shortController = BlocProvider.of<ShortBloc>(context, listen: false);

  VideoPlayerController? _videoPlayerController;
  bool _isLiked = false;
  bool _isDisLiked = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() {
    _isLiked = (widget.shortData.isLiked ?? 0) == 1;
    _isDisLiked = (widget.shortData.isDisliked ?? 0) == 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShortBloc, ShortState>(
      listener: (BuildContext context, state) {
        if (state is ShortFailState) {
          Utils.showToast(context, state.error ?? 'Error', status: false);
        }
      },
      child: Stack(
        children: [
          VideoPreview(
            arguments: VideoPreviewScreenArguments(
              path: widget.shortData.videoLocation ?? '',
              autoPlay: true,
              looping: true,
              allowFullScreen: false,
              showControlsOnInitialize: false,
              allowMuting: false,
              showControls: false,
              videoPlayerController: (chewieController) {
                _videoPlayerController = chewieController;
                if (widget.videoPlayerController != null) {
                  widget.videoPlayerController!(chewieController);
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: const [0.005, 0.3164, 0.7684],
                colors: [
                  AppColors.blackDf.withOpacity(0.6),
                  AppColors.blackDf.withOpacity(0.096),
                  AppColors.blackDf.withOpacity(0),
                ],
              ),
            ),
          ),
          CommonButton(
            onPress: _pauseAndPlay,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
              ).copyWith(bottom: 60, top: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.005, 0.314, 0.3641],
                  colors: [
                    AppColors.blackDf.withOpacity(0.6),
                    AppColors.blackDf.withOpacity(0.0851),
                    AppColors.blackDf.withOpacity(0),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildInfo(context), _buildActionShort(context)],
              ),
            ),
          ),
          if (_videoPlayerController != null && _videoPlayerController!.value.isPlaying == false)
            Center(
              child: CsIconButton(
                image: Assets.icPause,
                height: Dimens.dimens_50,
                onPress: _pauseAndPlay,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pauseAndPlay() async {
    if (_videoPlayerController == null) {
      return;
    }

    if (_videoPlayerController!.value.isPlaying) {
      await _videoPlayerController!.pause();
    } else {
      await _videoPlayerController!.play();
    }
    setState(() {});
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CacheImage(
              image: widget.shortData.owner?.avatar ?? '',
              size: const Size(32, 32),
              borderRadius: 18,
              errorLoadingImage: Assets.icAvatarDefault,
            ),
            Gap(ScreenUtil().setHeight(Dimens.dimens_08)),
            Text(
              widget.shortData.owner?.name ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.surfaceVariant,
                fontWeight: AppThemeData.medium,
              ),
            )
          ],
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_08)),
        SizedBox(
          width: Dimens.dimens_266,
          child: Text(
            widget.shortData.description ?? '',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.surfaceVariant,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionShort(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        BlocBuilder<ShortBloc, ShortState>(
          buildWhen: (previous, current) => current is ShortLikeDislikeVideoState && current != previous,
          builder: (context, state) {
            const success = 'added_like';
            if (state is ShortLikeDislikeVideoState) {
              _isLiked = state.successType == success;
            }

            return _buildItemAction(
              context,
              iconPath: _isLiked
                ? Assets.icLikeActive
                : Assets.icLikeOutline,
              title: 'like'.tr(context),
              onTap: () {
                _shortController.add(
                  ShortEvent.likedOrDislikedVideo(
                    argumentsLikeDislike: ArgumentsLikeDislike(
                      videoId: widget.shortData.id ?? -1,
                      action: ActionsLikeOrDislike.like,
                    ),
                  ),
                );
              },
            );
          },
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_19)),
        BlocBuilder<ShortBloc, ShortState>(
          buildWhen: (previous, current) => current is ShortLikeDislikeVideoState && current != previous,
          builder: (context, state) {
            const success = 'added_dislike';
            if (state is ShortLikeDislikeVideoState) {
              _isDisLiked = state.successType == success;
            }

            return _buildItemAction(
              context,
              iconPath: _isDisLiked
                ? Assets.icDislikeActive
                : Assets.icDislikeOutline,
              title: 'dislike'.tr(context),
              onTap: () {
                _shortController.add(
                  ShortEvent.likedOrDislikedVideo(
                    argumentsLikeDislike: ArgumentsLikeDislike(
                      videoId: widget.shortData.id ?? -1,
                      action: ActionsLikeOrDislike.dislike,
                    ),
                  ),
                );
              },
            );
          },
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_19)),
        _buildItemAction(
          context,
          iconPath: Assets.icChat,
          title: '10',
          onTap: () {},
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_19)),
        _buildItemAction(
          context,
          iconPath: Assets.icShare,
          title: 'share'.tr(context),
          onTap: () => BottomSheetShare.handleLogicActionsShare(context),
        ),
      ],
    );
  }

  Widget _buildItemAction(
    BuildContext context, {
    required String iconPath,
    required String title,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          Gap(ScreenUtil().setHeight(Dimens.dimens_07)),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
