// ignore_for_file: cascade_invocations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';
import 'package:theshowplayer/widgets/components/category.dart';

import '../../constants/app_theme.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/enum/type_status_items.dart';
import '../../widgets/components/horizontal_list.dart';
import '../../widgets/components/live_channel_items.dart';
import '../../widgets/components/short_items.dart';
import '../../widgets/divider/divider.dart';
import '../../widgets/image/cache_image.dart';

class LiveScreenMobile extends StatelessWidget {
  const LiveScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: Dimens.dimens_50, top: ScreenUtil().setHeight(Dimens.dimens_45)),
      child: Column(
        children: <Widget>[
          CategoryItems(
            titleLeft: 'top_live'.tr(context),
            onTabAddMore: () async {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(bottom: Dimens.dimens_20),
              child: Builder(
                builder: (context) {
                  final datas = List.generate(10, (index) => index);

                  final lives = datas.map<Widget>((e) {
                    return LiveAndChannelItems(
                      imageBackground: 'https://images.unsplash.com/photo-1606792109963-7b34205b1333?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjR8fHNleHklMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                      avatar: 'https://images.unsplash.com/photo-1606792109963-7b34205b1333?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjR8fHNleHklMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                      name: 'Rose',
                      onPress: _handleLogicNavigateToLiveStreamScreen,
                      size: Size(ScreenUtil().setWidth(Dimens.dimens_200), ScreenUtil().setWidth(Dimens.dimens_220)),
                      listTypeStatusItems: const [TypeStatusItems.live],
                      infoLivesChannels: const InfoLivesChannels(numViews: '20k', numMins: '30', title: 'Chilling with Mei Mei'),
                    );
                  }).toList();

                  lives.insert(
                    lives.isEmpty ? 0 : 1,
                    _takeALookPremiumVideos(
                      context,
                      backgroundImage: 'https://images.unsplash.com/photo-1593309403015-6c71b1921119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDB8fHNleHklMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                      numPremiumVideos: '10.000+',
                    ),
                  );

                  lives.insert(lives.length, _addMore(context, 20, () async {}));

                  return MasonryGridView.count(
                    itemCount: lives.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimens.dimens_30,
                    crossAxisSpacing: Dimens.dimens_12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return lives[index];
                    },
                  );
                },
              ),
            ),
          ),
          HorizontalList(
            height: 234,
            data: List.generate(10, (index) {
              return ShortItems(
                imageBackground: 'https://images.unsplash.com/photo-1595053863588-e329cc81e105?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjJ8fHNleHklMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                title: 'Bikini Quick look-book',
                onPress: () async {},
                size: Size(ScreenUtil().setWidth(Dimens.dimens_130), ScreenUtil().setHeight(Dimens.dimens_250)),
                numberView: '20k',
              );
            }),
            titleLeft: 'shorts'.tr(context),
            titleRight: 'view_all'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(Dimens.dimens_20)),
          _divider(context),
        ],
      ),
    );
  }

  Future<void> _handleLogicNavigateToLiveStreamScreen() async {
    await navigation.navigateTo(RouterName.liveStream);
  }

  Widget _addMore(BuildContext context, int numAddMore, AsyncCallback? onPress) {
    return CommonButton(
      onPress: onPress,
      child: Container(
        width: double.infinity,
        height: Dimens.dimens_96,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(Dimens.dimens_12),
        ),
        child: Center(
          child: Text(
            '$numAddMore+ ${'more'.tr(context).toLowerCase()}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: AppThemeData.semiBold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _takeALookPremiumVideos(
    BuildContext context, {
    required String backgroundImage,
    String? numPremiumVideos,
    AsyncCallback? onPress,
  }) {
    final size = Size(double.infinity, ScreenUtil().setWidth(Dimens.dimens_100));

    return CommonButton(
      onPress: onPress,
      child: Stack(
        children: [
          CacheImage(
            image: backgroundImage,
            size: size,
            borderRadius: Dimens.dimens_12,
          ),
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.1, 0.2, 0.72],
                colors: [
                  AppColors.black.withOpacity(0.7),
                  AppColors.black.withOpacity(0.53),
                  AppColors.black.withOpacity(0),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${numPremiumVideos != null ? '$numPremiumVideos\n' : ''}${'premium_videos'.tr(context)}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: AppThemeData.semiBold,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    height: 1.2,
                  ),
                ),
                Gap(size.height * .04),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.height * .09, vertical: size.height * .06),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(Dimens.dimens_11),
                  ),
                  child: Text(
                    'take_a_look'.tr(context),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: AppThemeData.semiBold,
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
    child: CustomDivider(
      height: 1,
      color: Theme.of(context).colorScheme.surfaceTint,
    ),
  );

}
