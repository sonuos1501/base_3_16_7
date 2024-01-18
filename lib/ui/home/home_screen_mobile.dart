import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/home/homevideos_data.dart';
import 'package:theshowplayer/ui/home/bloc/home_bloc.dart';
import 'package:theshowplayer/ui/home/component/hot_video.dart';
import 'package:theshowplayer/ui/home/component/vertical_list.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/components/horizontal_list.dart';
import 'package:theshowplayer/widgets/components/video_items.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';
import 'package:theshowplayer/widgets/empty_box/empty_box.dart';

import '../../configs/routers/router_name.dart';
import '../../constants/colors.dart';
import '../../constants/enum/type_status_items.dart';
import '../../di/action_method_locator.dart';
import '../../models/home/alllistvideos_data.dart';
import '../../models/home/categories_data.dart';
import '../../models/home/channel_might_like.dart';
import '../../models/video_detail_model/video_detail_model.dart';
import '../../widgets/components/live_channel_items.dart';
import '../../widgets/components/short_items.dart';
import '../../widgets/loading/loading_view.dart';
import '../dashboard/bloc/dashboard_bloc.dart';
import '../dashboard/components/drawer.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({
    super.key,
    required this.categories,
  });

  final List<DetailCategory> categories;

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  late final _homeController = BlocProvider.of<HomeBloc>(context, listen: false);

  final _latestVideo = <VideoDetailModel>[];
  final _hotVideo = <VideoDetailModel>[];
  final _discovery = <VideoDetailModel>[];
  final _shorts = <VideoDetailModel>[];
  final _channelYouMightLike = <ChannelMightLike>[];
  final _categoriesVideo = <Category>[];

  int _pageOfLastestVideo = 1;
  final _pageOfCategory = <String, int>{};

  @override
  Widget build(BuildContext context) {
    final dataVideosByOptionsOfDrawer = <VideoDetailModel>[];

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const LoadingView();
        } else if (state is HomeAllListVideosState) {
          return Stack(
            children: [
              _buildVideosByOptionsOfDrawer(
                context,
                state.categoriesData ?? AllListVideosData(),
                dataVideosByOptionsOfDrawer,
                page: state.page,
                isLoading: state.isLoading,
              ),
              if (state.isLoading) const LoadingView(),
            ],
          );
        }

        if (state is HomeGetHomeVideosState && state.haveClearData) {
          _latestVideo.clear();
          _hotVideo.clear();
          _discovery.clear();
          _shorts.clear();
          _channelYouMightLike.clear();
          _categoriesVideo.clear();
        }

        return Stack(
          children: [
            _buildHomeMain(context, state is HomeGetHomeVideosState ? state.homeVideosData ?? HomeVideosData() : HomeVideosData()),
            if (state is HomeGetHomeVideosState ? state.isLoading : false) const LoadingView(),
          ],
        );
      },
    );
  }

  Widget _buildVideosByOptionsOfDrawer(
    BuildContext context,
    AllListVideosData allListVideosData,
    List<VideoDetailModel> dataVideosByOptionsOfDrawer, {
    int page = 1,
    bool isLoading = false,
  }) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => current is DrawerTypeState && previous != current,
      builder: (context, drawerState) {
        var title = '';

        if (drawerState is DrawerTypeState) {
          switch (drawerState.drawerType) {
            case DrawerType.allVideo:
              break;
            case DrawerType.topVideo:
              title = 'top_video'.tr(context);
              dataVideosByOptionsOfDrawer.addAll(allListVideosData.top ?? []);
              break;
            case DrawerType.latest:
              title = 'latest'.tr(context);
              dataVideosByOptionsOfDrawer.addAll(allListVideosData.latest ?? []);
              break;
            case DrawerType.onTrend:
              title = 'on_trend'.tr(context);
              dataVideosByOptionsOfDrawer.addAll(allListVideosData.featured ?? []);
              break;
            case DrawerType.popular:
              title = 'popular'.tr(context);
              dataVideosByOptionsOfDrawer.addAll(allListVideosData.fav ?? []);
              break;
          }
        }

        return dataVideosByOptionsOfDrawer.isEmpty
          ? Center(child: isLoading ? const LoadingView() : EmptyBox(title: '$title ${'no_element'.tr(context)}'))
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimens.dimens_60, bottom: Dimens.dimens_50),
              child: VerticalList(
                titleLeft: title,
                onTabAddMore: () async => _handleLogicLoadMore(drawerState, page),
                data: dataVideosByOptionsOfDrawer.map((e) {
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
                  );
                }).toList(),
              ),
            ),
          );
      },
    );
  }

  void _handleLogicLoadMore(DashboardState drawerState, int page) {
    if (drawerState is DrawerTypeState) {
      switch (drawerState.drawerType) {
        case DrawerType.allVideo:
          break;
        case DrawerType.topVideo:
          _homeController.add(HomeEvent.loadedAllListVideos(argumentsAllListVideosData: ArgumentsAllListVideosData(
            topOffset: page + 1,
          ),),);
          break;
        case DrawerType.latest:
          _homeController.add(HomeEvent.loadedAllListVideos(argumentsAllListVideosData: ArgumentsAllListVideosData(
            latestOffset: page + 1,
          ),),);
          break;
        case DrawerType.onTrend:
          _homeController.add(HomeEvent.loadedAllListVideos(argumentsAllListVideosData: ArgumentsAllListVideosData(
            featuredOffset: page + 1,
          ),),);
          break;
        case DrawerType.popular:
          _homeController.add(HomeEvent.loadedAllListVideos(argumentsAllListVideosData: ArgumentsAllListVideosData(
            favOffset: page + 1,
          ),),);
          break;
      }
    }
  }

  Widget _buildHomeMain(
    BuildContext context,
    HomeVideosData homeVideosData,
  ) {
    _hotVideo.addAll(homeVideosData.hot ?? []);
    _discovery.addAll(homeVideosData.discovery ?? []);
    _latestVideo.addAll(homeVideosData.lastest ?? []);
    _shorts.addAll(homeVideosData.short ?? []);
    _channelYouMightLike.addAll(homeVideosData.channelMightLike ?? []);
    if (_categoriesVideo.isEmpty) {
      _categoriesVideo.addAll(homeVideosData.category ?? []);
    } else {
      try {
        final categoriesInNetwork = homeVideosData.category ?? [];
        for (final e in categoriesInNetwork) {
          for (final element in _categoriesVideo) {
            if (e.id == element.id) {
              element.values = (element.values ?? [])..addAll(e.values ?? []);
            }
          }
        }
      } catch (_) {}
    }
    if (_pageOfCategory.isEmpty) {
      for (final e in _categoriesVideo) {
        _pageOfCategory[e.id.toString()] = 1;
      }
    }

    return ListView(
      children: [
        if (_hotVideo.isNotEmpty) ...[
          HotVideo(videoDetail: _hotVideo.first, categories: widget.categories),
          Gap(ScreenUtil().setHeight(12)),
          _divider(context),
        ],
        if (_discovery.isNotEmpty) ...[
          Gap(ScreenUtil().setHeight(12)),
          HorizontalList(
            titleLeft: 'discovery'.tr(context),
            data: _discovery.map((e) {
              return LiveAndChannelItems(
                imageBackground: e.thumbnail ?? '',
                name: e.owner?.name ?? '',
                avatar: e.owner?.avatar ?? '',
                onPress: () async {},
                size: const Size(132, 172),
                listTypeStatusItems: const [TypeStatusItems.live],
              );
            }).toList(),
            titleRight: 'view_all'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(20)),
          _divider(context),
        ],
        if (_latestVideo.isNotEmpty) ...[
          Gap(ScreenUtil().setHeight(20)),
          VerticalList(
            titleLeft: 'latest_video'.tr(context),
            onTabAddMore: () async {
              ++_pageOfLastestVideo;
              _homeController.add(HomeEvent.loadedHomeVideos(argumentsHomeVideosData: ArgumentsHomeVideosData(
                page: _pageOfLastestVideo,
                moreByType: 'lastest',
              ),),);
            },
            data: _latestVideo.map((e) {
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
              );
            }).toList(),
          ),
        ],
        if (_shorts.isNotEmpty) ...[
          Gap(ScreenUtil().setHeight(20)),
          HorizontalList(
            data: _shorts.map((e) {
              return ShortItems(
                imageBackground: e.thumbnail ?? '',
                title: e.title ?? '',
                onPress: () async {},
                size: Size(ScreenUtil().setWidth(Dimens.dimens_130), ScreenUtil().setHeight(Dimens.dimens_250)),
                numberView: (e.views ?? 0).toString(),
              );
            }).toList(),
            height: ScreenUtil().setHeight(Dimens.dimens_180),
            titleLeft: 'shorts'.tr(context),
            titleRight: 'view_all'.tr(context),
          ),
          Gap(ScreenUtil().setHeight(12)),
          _divider(context),
        ],
        if (_channelYouMightLike.isNotEmpty) ...[
          Gap(ScreenUtil().setHeight(20)),
          HorizontalList(
            data: _channelYouMightLike.map((e) {
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
            titleLeft: 'channel_you_might_like'.tr(context),
            titleRight: 'view_all'.tr(context),
            height: 150,
          ),
          Gap(ScreenUtil().setHeight(12)),
          _divider(context),
        ],
        if (_categoriesVideo.isNotEmpty) ...[
          ...List.generate(
            _categoriesVideo.length,
            (index) {
              final category = _categoriesVideo[index];
              final titleCategory = widget.categories.firstWhere(
                (element) => element.id.toString().toLowerCase() == category.id.toString().toLowerCase(),
                orElse: DetailCategory.new,
              ).description ?? '';
              final listVideosOfCategory = (category.values ?? []).map((e) {
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
                );
              }).toList();

              return titleCategory.isNotEmpty && (category.values ?? []).isNotEmpty
                ? Column(
                  children: [
                    Gap(ScreenUtil().setHeight(20)),
                    VerticalList(
                      titleLeft: titleCategory,
                      onTabAddMore: () async {
                        _pageOfCategory[category.id.toString()] = _pageOfCategory[category.id.toString()]! + 1;
                        _homeController.add(HomeEvent.loadedHomeVideos(argumentsHomeVideosData: ArgumentsHomeVideosData(
                          page: _pageOfCategory[category.id.toString()],
                          moreByType: category.id,
                        ),),);
                      },
                      data: listVideosOfCategory,
                    ),
                  ],
                )
                : const SizedBox.shrink();
            },
          ),
        ],
        Gap(ScreenUtil().setHeight(30)),
      ],
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
