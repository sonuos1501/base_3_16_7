
// ignore_for_file: inference_failure_on_function_invocation



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../../../constants/app_theme.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/bottom_sheet/BottomSheetUtil.dart';
import '../../../../utils/regex/regex.dart';
import '../../../../widgets/bottom_sheet/bottom_sheet_share.dart';
import '../../../../widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import '../../../../widgets/components/type_share.dart';
import '../../../../widgets/image/cache_image.dart';
import '../../../../widgets/input/basic_text_field.dart';

class ItemLiveStream extends StatelessWidget {
  const ItemLiveStream({
    super.key,
    required this.link,
  });

  final String link;

  @override
  Widget build(BuildContext context) {
    return _buildLiveStream(context);
  }

  Widget _buildLiveStream(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundLive(),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.dimens_08),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.3821, 1.2709],
              colors: [
                AppColors.black111111.withOpacity(0),
                AppColors.black111111
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
              child: PageView(
                controller: PageController(),
                physics: const BouncingScrollPhysics(),
                children: [
                  _displayInformations(context),
                  _hideInformations(context),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _hideInformations(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.topRight, child: _buildClose(context)),
        const Spacer(),
        Row(
          children: [
            SvgPicture.asset(
              Assets.icDisplayComment,
              height: Dimens.dimens_20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const Gap(Dimens.dimens_10),
            Expanded(
              child: Text(
                'live_mg0'.tr(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: AppThemeData.regular,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildClose(BuildContext context) {
    return _backgroundOfOptions(
      context,
      icon: Icon(Icons.close, color: Theme.of(context).colorScheme.surfaceVariant, size: Dimens.dimens_15),
      onPress: () async => navigation.pop(),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return _backgroundOfOptions(
      context,
      icon: SvgPicture.asset(Assets.icMenuSettingsHorizontal),
      onPress: () async {},
    );
  }

  Widget _backgroundOfOptions(
    BuildContext context, {
    required Widget icon,
    AsyncCallback? onPress,
  }) {
    const size = Dimens.dimens_24;

    return CommonButton(
      onPress: onPress,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimens.dimens_05),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: icon,
      ),
    );
  }

  Widget _displayInformations(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(child: _buildBody(context)),
        _buildComments(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 2, child: _buildListComments(context)),
        Expanded(flex: 1, child: _buildListActions(context),),
      ],
    );
  }

  Widget _buildListComments(BuildContext context) {
    final comments = List.generate(10, (index) => index);

    return Stack(
      children: [
        SizedBox(
          height: Dimens.dimens_430,
          child: ListView.builder(
            itemCount: comments.length,
            reverse: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.dimens_16),
                child: _itemComment(
                  context,
                  avatar: 'https://image.baophapluat.vn/1200x630/Uploaded/2023/gznrxgmabianhgzmath/2021_07_16/blackpink-rose5-4847.jpg',
                  name: 'Rose',
                  time: DateTime.now(),
                  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus arcu turpis',
                ),
              );
            },
          ),
        ),
        if (comments.length > 3) Container(
          alignment: Alignment.topCenter,
          height: Dimens.dimens_120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.dimens_12),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
              colors: [
                Colors.transparent,
                AppColors.white.withOpacity(.4),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemComment(
    BuildContext context, {
    required String name,
    required DateTime time,
    required String content,
    String? avatar,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null) _avatar(
                avatar: avatar,
              ),
            ],
          ),
        ),
        const Gap(Dimens.dimens_05),
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.all(Dimens.dimens_08),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.2),
              borderRadius: BorderRadius.circular(Dimens.dimens_12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: AppThemeData.semiBold,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                      ),
                    ),
                    const Gap(Dimens.dimens_05),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${time.minute}:${time.second}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: AppThemeData.regular,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Dimens.dimens_05),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: AppThemeData.regular,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  Column _buildListActions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildButtonAction(context, icon: Assets.icAddUser),
        const Gap(Dimens.dimens_16),
        _buildButtonAction(context, icon: Assets.icLikeOutline),
        const Gap(Dimens.dimens_16),
        _buildButtonAction(context, icon: Assets.icDislikeOutline),
        const Gap(Dimens.dimens_16),
        _buildButtonAction(context, icon: Assets.icShare, onPress: () => BottomSheetShare.handleLogicActionsShare(context)),
      ],
    );
  }

  Widget _buildButtonAction(
    BuildContext context, {
    required String icon,
    AsyncCallback? onPress,
  }) {
    const size = Dimens.dimens_40;

    return CommonButton(
      onPress: onPress,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(Dimens.dimens_05),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Dimens.dimens_12),
        ),
        child: SvgPicture.asset(icon, height: Dimens.dimens_19),
      ),
    );
  }

  BasicTextField _buildComments(BuildContext context) {
    return BasicTextField(
      controller: TextEditingController(),
      regexConfig: RegexConstant.none,
      keyboardType: TextInputType.text,
      borderRadius: Dimens.dimens_12,
      hintText: 'comment'.tr(context),
      fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.2),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildInfoUser(context)),
        const Gap(Dimens.dimens_16),
        Expanded(flex: 1, child: _buildOptions(context)),
      ],
    );
  }

  Widget _buildInfoUser(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_15, vertical: Dimens.dimens_12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.2),
        borderRadius: BorderRadius.circular(Dimens.dimens_12),
      ),
      child: Row(
        children: [
          _avatar(
            avatar: 'https://image.baophapluat.vn/1200x630/Uploaded/2023/gznrxgmabianhgzmath/2021_07_16/blackpink-rose5-4847.jpg',
            haveBorder: true,
          ),
          const Gap(Dimens.dimens_10),
          Expanded(child: _name(context)),
          const Gap(Dimens.dimens_10),
          _view(context),
        ],
      ),
    );
  }

  CacheImage _avatar({ required String avatar, bool haveBorder = false }) {
    const size = Dimens.dimens_28;

    return CacheImage(
      image: avatar,
      size: const Size(size, size),
      borderRadius: size / 2,
      imageBuilder: haveBorder
        ? (context, imageProvider) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        }
        : null,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Text _view(BuildContext context) {
    return Text(
      '10',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: AppThemeData.regular,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      ),
    );
  }

  Text _name(BuildContext context) {
    return Text(
      'Rose - BlackPink',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: AppThemeData.medium,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Row _buildOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildMenu(context),
        const Gap(Dimens.dimens_16),
        _buildClose(context),
      ],
    );
  }

  Widget _buildBackgroundLive() {
    return CacheImage(
      image: link,
      size: Size.infinite,
      borderRadius: Dimens.dimens_00,
    );
  }

}
