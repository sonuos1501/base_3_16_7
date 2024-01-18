import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/home/channel_might_like.dart';
import 'package:theshowplayer/models/premiums/argument_most_buy_videos.dart';
import 'package:theshowplayer/ui/premium/bloc/premium_bloc.dart';
import 'package:theshowplayer/ui/premium/components/top.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/components/category.dart';
import 'package:theshowplayer/widgets/components/horizontal_list.dart';
import 'package:theshowplayer/widgets/components/live_channel_items.dart';
import 'package:theshowplayer/widgets/components/video_items.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';

import '../../configs/routers/router_name.dart';
import '../../di/action_method_locator.dart';
import '../../models/video_detail_model/video_detail_model.dart';
import '../../widgets/empty_box/empty_box.dart';
import '../../widgets/loading/loading_view.dart';

class PremiumScreenMobile extends StatefulWidget {
  const PremiumScreenMobile({super.key});

  @override
  State<PremiumScreenMobile> createState() => _PremiumScreenMobileState();
}

class _PremiumScreenMobileState extends State<PremiumScreenMobile> {
  late final _premiumController = BlocProvider.of<PremiumBloc>(context, listen: false);

  final _mostBuyVideos = <VideoDetailModel>[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PremiumBloc, PremiumState>(
      buildWhen: (previous, current) => current is! PremiumLoadingState && current != previous,
      listener: (context, state) {
        if (state is PremiumLoadingState) {
          LoadingProcessBuilder.showProgressDialog();
        } else {
          LoadingProcessBuilder.closeProgressDialog();
        }
      },
      builder: (context, state) {
        if (state is PremiumLoadingState) {
          return const LoadingView();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const TopPremium(),
              Gap(ScreenUtil().setHeight(20)),
              _divider(context),
              Gap(ScreenUtil().setHeight(20)),
              BlocBuilder<PremiumBloc, PremiumState>(
                buildWhen: (previous, current) => current is PremiumListMostBuyVideosState && current != previous,
                builder: (context, state) {
                  var page = 1;
                  if (state is PremiumListMostBuyVideosState) {
                    if (state.haveClearData) {
                      _mostBuyVideos.clear();
                    }
                    _mostBuyVideos.addAll(state.listMostBuyVideos);
                    page = state.page;
                  }

                  return CategoryItems(
                    titleLeft: 'most_buy'.tr(context),
                    onTabAddMore: _mostBuyVideos.isEmpty || (state is PremiumListMostBuyVideosState ? state.listMostBuyVideos : <VideoDetailModel>[]).isEmpty
                      ? null
                      : () async {
                        _premiumController.add(
                          PremiumEvent.loadedMostBuyVideos(
                            argumentsMostBuyVideosData: ArgumentsMostBuyVideosData(offset: page + 1),
                          ),
                        );
                      },
                    child: _mostBuyVideos.isEmpty
                      ? EmptyBox(title: 'no_element'.tr(context))
                      : _buildMostBuy(
                        context,
                        data: _mostBuyVideos.map((e) {
                          return VideoItems(
                            avatar: e.owner?.avatar ?? '',
                            imageBackground: e.thumbnail ?? '',
                            name: e.owner?.name ?? '',
                            onPress: () async {
                              await navigation.navigateTo(RouterName.watchScreen, arguments: e);
                            },
                            onPressSettings: () async {},
                            time: e.duration ?? '00:00:00',
                            title: e.title ?? '',
                            isPremium: true,
                            // listTypeStatusItems: const [TypeStatusItems.sale],
                            money: 26.99,
                            numberSolds: 6,
                            saleMoney: 16.99,
                          );
                        }).toList(),
                      ),
                  );
                },
              ),
              Gap(ScreenUtil().setHeight(20)),
              BlocBuilder<PremiumBloc, PremiumState>(
                buildWhen: (previous, current) => current is PremiumListChannelYouMightLikeState && current != previous,
                builder: (context, state) {
                  final channels = <ChannelMightLike>[];
                  if (state is PremiumListChannelYouMightLikeState) {
                    channels.addAll(state.listChannelYouMightLike);
                  }

                  return HorizontalList(
                    titleLeft: 'channel_you_might_like'.tr(context),
                    titleRight: 'view_all'.tr(context),
                    data: channels.map((e) {
                      return LiveAndChannelItems(
                        imageBackground: e.userData?.fullCover ?? '',
                        avatar: e.userData?.avatar ?? '',
                        name: e.userData?.name ?? '',
                        onPress: () async {},
                        size: const Size(180, 110),
                        listTypeStatusItems: const [],
                        infoLivesChannels: InfoLivesChannels(
                          numVideos: e.count,
                          numViews: e.views,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0, 0.12, 0.82],
                          colors: [
                            AppColors.black1D1313.withOpacity(0.9),
                            AppColors.black1B1313.withOpacity(0.78),
                            AppColors.black121212.withOpacity(0),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              // Gap(ScreenUtil().setHeight(30)),
            ],
          ),
        );
      },
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
    child: CustomDivider(
      height: 1,
      color: Theme.of(context).colorScheme.surfaceTint,
    ),
  );

  Widget _buildMostBuy(BuildContext context, {required List<VideoItems> data}) {
    return Column(
      children: List.generate(data.length, (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(bottom: Dimens.dimens_16),
        child: data[index],
      ),),
    );
  }
}
