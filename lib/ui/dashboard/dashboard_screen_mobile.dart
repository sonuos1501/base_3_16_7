import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:theshowplayer/blocs/common_blocs/language/language_bloc.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/models/channels/short_data.dart';
import 'package:theshowplayer/models/home/alllistvideos_data.dart';
import 'package:theshowplayer/models/home/categories_data.dart';
import 'package:theshowplayer/models/home/homevideos_data.dart';
import 'package:theshowplayer/models/premiums/argument_most_buy_videos.dart';
import 'package:theshowplayer/models/video_detail_model/video_detail_model.dart';
import 'package:theshowplayer/ui/channel/bloc/channel_bloc.dart';
import 'package:theshowplayer/ui/channel/channel_screen.dart';
import 'package:theshowplayer/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:theshowplayer/ui/dashboard/components/drawer.dart';
import 'package:theshowplayer/ui/dashboard/components/persistent_bottom_bar.dart';
import 'package:theshowplayer/ui/home/bloc/home_bloc.dart';
import 'package:theshowplayer/ui/home/home_screen.dart';
import 'package:theshowplayer/ui/live/bloc/live_bloc.dart';
import 'package:theshowplayer/ui/live/live_screen.dart';
import 'package:theshowplayer/ui/premium/bloc/premium_bloc.dart';
import 'package:theshowplayer/ui/premium/premium_screen.dart';
import 'package:theshowplayer/ui/short/bloc/short_bloc.dart';
import 'package:theshowplayer/ui/short/short_screen.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';
import 'package:theshowplayer/widgets/menu_nav/menu_nav.dart';
import 'package:video_player/video_player.dart';

import '../../constants/enum/filter_by_datetime.dart';
import '../../constants/enum/filter_by_properties.dart';
import '../../models/channels/response_get_top_channels.dart';



class DashBoardScreenMobile extends StatefulWidget {
  const DashBoardScreenMobile({super.key});

  @override
  State<DashBoardScreenMobile> createState() => _DashBoardScreenMobileState();
}

class _DashBoardScreenMobileState extends State<DashBoardScreenMobile> {
  VideoPlayerController? _videoPlayerController;
  final _tabController = PersistentTabController();
  late final _homeController = BlocProvider.of<HomeBloc>(context, listen: false);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Dimens.dimens_50),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) => current is CurrentSelecteBottomNavigator && previous != current,
          builder: (context, bottomNavState) {
            return (bottomNavState is CurrentSelecteBottomNavigator ? bottomNavState.index : 0) != 1
              ? AppbarView(
                onSearchTap: () => navigation.navigateTo(RouterName.search),
                onMessTap: () => navigation.navigateTo(RouterName.message),
              )
              : const SizedBox.shrink();
          },
        ),
      ),
      drawer: BlocConsumer<DashboardBloc, DashboardState>(
        buildWhen: (previous, current) => current is DrawerTypeState && previous != current,
        listener: (context, state) {
          _handleLogicLoadDataByDrawerType(state);
        },
        builder: (context, state) {
          return DrawerCustom(
            drawerType: state is DrawerTypeState
              ? state.drawerType
              : DrawerType.allVideo,
          );
        },
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        buildWhen: (previous, current) => current is HideBottomNavState && previous != current,
        builder: (context, state) {
          return PersistentTabView(
            context,
            controller: _tabController,
            hideNavigationBar: state is HideBottomNavState ? state.hideBottomNav : false,
            navBarStyle: NavBarStyle.style6,
            backgroundColor: Theme.of(context).colorScheme.surface,
            navBarHeight: 80,
            padding: const NavBarPadding.only(top: 15),
            onItemSelected: _handleLogicOnItemSelectedTab,
            decoration: NavBarDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0,-3),
                ),
              ],
            ),
            items: [
              persistentBottomNavBarItem(
                context,
                activeIconPath: Assets.icHomeBottomTabActive,
                inactiveIconPath: Assets.icHomeBottomTab,
                title: 'home'.tr(context),
              ),
              persistentBottomNavBarItem(
                context,
                activeIconPath: Assets.icShortBottomTabActive,
                inactiveIconPath: Assets.icShortBottomTab,
                title: 'short'.tr(context),
              ),
              persistentBottomNavBarItem(
                context,
                activeIconPath: Assets.icPremiumBottomTabActive,
                inactiveIconPath: Assets.icPremiumBottomTab,
                title: 'premium'.tr(context),
              ),
              persistentBottomNavBarItem(
                context,
                activeIconPath: Assets.icLiveBottomTabActive,
                inactiveIconPath: Assets.icLiveBottomTab,
                title: 'live'.tr(context),
              ),
              persistentBottomNavBarItem(
                context,
                activeIconPath: Assets.icChannelBottomTabActive,
                inactiveIconPath: Assets.icChannelBottomTab,
                title: 'channels'.tr(context),
              ),
            ],
            screens: [
              _buildTabHome(),
              _buildTabShort(),
              _buildTabPremium(),
              _buildTabLive(),
              _buildTabChannel(),
            ],
          );
        },
      ),
    );
  }

  void _handleLogicOnItemSelectedTab(int index) {
    sl<DashboardBloc>().add(DashboardEvent.selectedItemBottomNavigator(index: index));
    setState(() {
      if (_videoPlayerController != null) {
        if (index != 1) {
          _videoPlayerController?.pause();
        }
        // else {
        //   _chewieController!.play();
        // }
      }
    });

    switch (index) {
      case 0:
        sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.allVideo));
        _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
        _homeController.add(
          const HomeEvent.loadedHomeVideos(
            argumentsHomeVideosData: ArgumentsHomeVideosData(
              haveClearData: true,
            ),
          ),
        );
        return;
      case 1:
        return BlocProvider.of<ShortBloc>(context, listen: false).add(
          const ShortEvent.loadedShortVideos(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              shortOffset: 1,
            ),
          ),
        );
      case 2:
        final controllerPremium = BlocProvider.of<PremiumBloc>(context, listen: false);
        controllerPremium.add(
          const PremiumEvent.loadedMostBuyVideos(
            argumentsMostBuyVideosData: ArgumentsMostBuyVideosData(
              offset: 1,
              haveClearData: true,
            ),
          ),
        );
        controllerPremium.add(
          const PremiumEvent.loadedChannelYouMightLike(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              channelOffset: 1,
            ),
          ),
        );
        return;
      case 4:
        return BlocProvider.of<ChannelBloc>(context, listen: false).add(
          ChannelEvent.loaded(
            argumentGetTopChannels: ArgumentGetTopChannels(
              type: FilterByProperties.views.key,
              sortType: FilterByDatetime.allTime.key,
            ),
          ),
        );
    }
  }

  Widget _buildTabChannel() {
    return const ChannelScreen();
  }

  BlocProvider<LiveBloc> _buildTabLive() {
    return BlocProvider<LiveBloc>(
      create: (context) => sl.get<LiveBloc>(),
      child: Stack(
        children: [
          const LiveScreen(),
          BlocBuilder<LiveBloc, LiveState>(
            buildWhen: (previous, current) => current is LiveMenuState && previous != current,
            builder: (context, state) {
              return MenuNav(
                menuList: const [
                  'All',
                  'Live',
                  'Live Influencer',
                  'Live Top Video',
                  'Live Top Trend',
                  'Etc'
                ],
                onTapItem: (idx) {
                  sl.get<LiveBloc>().add(LiveEvent.selectMenu(index: idx));
                },
                indexSelected: state is LiveMenuState
                  ? state.currentIndexMenu
                  : 0,
                openDraw: () {
                  Scaffold.of(context).openDrawer();
                  sl.get<DashboardBloc>().add(const HideBottomNavEvent(isHiveBottomNav: true));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  PremiumScreen _buildTabPremium() => const PremiumScreen();

  BlocBuilder<ShortBloc, ShortState> _buildTabShort() {
    return BlocBuilder<ShortBloc, ShortState>(
      buildWhen: (previous, current) => current is ShortGetShortVideosState && current != previous,
      builder: (context, state) {
        final shorts = <VideoDetailModel>[];
        var isLoading = false;
        if (state is ShortGetShortVideosState) {
          shorts.addAll(state.shorts ?? []);
          isLoading = state.isLoading;
        }

        return isLoading
          ? const LoadingView()
          : ShortScreen(
            listShort: shorts.map((e) => ShortData.fromJson(e.toJson())).toList(),
            index: 0,
            videoPlayerController: (chewieController) {
              _videoPlayerController = chewieController;
            },
          );
      },
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildTabHome() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeCategoriesState && previous != current,
      builder: (context, state) {
        var categoriesData = CategoriesData();
        if (state is HomeCategoriesState) {
          categoriesData = state.categoriesData ?? CategoriesData();
        }

        return BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => current is HomeMenuState && previous != current,
          builder: (context, menuState) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              buildWhen: (previous, current) => current is AppLanguageState && previous != current,
              builder: (context, lang) {
                final categories = (lang.language.locale == 'vi'
                  ? categoriesData.vi
                  : lang.language.locale == 'en'
                    ? categoriesData.en
                    : categoriesData.ko) ?? [];

                return Stack(
                  fit: StackFit.loose,
                  children: [
                    HomeScreen(categories: categories),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      buildWhen: (previous, current) => current is DrawerTypeState && previous != current,
                      builder: (context, state) {
                        return MenuNav(
                          openDraw: () {
                            Scaffold.of(context).openDrawer();
                            sl.get<DashboardBloc>().add(const HideBottomNavEvent(isHiveBottomNav: true));
                          },
                          menuList: categories.map((e) => e.description ?? '').toList()..insert(0, 'all'.tr(context)),
                          onTapItem: (idx) {
                            _homeController.add(HomeEvent.selectedMenu(currentIndexMenu: idx));
                            if (idx == 0) {
                              _homeController.add(
                                const HomeEvent.loadedHomeVideos(
                                  argumentsHomeVideosData: ArgumentsHomeVideosData(
                                    haveClearData: true,
                                  ),
                                ),
                              );
                            } else {
                              _handleLogicLoadDataByDrawerType(state, categoryId: categories[idx - 1].id);
                            }
                          },
                          indexSelected: menuState is HomeMenuState
                            ? menuState.currentIndexMenu
                            : 0,
                        );
                      },
                    ),
                    // Container(height: 100,color: Colors.red,margin: const EdgeInsets.only(bottom: 100),),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _handleLogicLoadDataByDrawerType(
    DashboardState state, {
    dynamic categoryId,
  }) {
    switch (state is DrawerTypeState ? state.drawerType : DrawerType.allVideo) {
      case DrawerType.allVideo:
        _homeController.add(
          HomeEvent.loadedHomeVideos(
            argumentsHomeVideosData: ArgumentsHomeVideosData(
              categoryId: categoryId,
              haveClearData: true,
            ),
          ),
        );
        break;
      case DrawerType.topVideo:
        _homeController.add(
          HomeEvent.loadedAllListVideos(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              topOffset: 1,
              categoryId: categoryId,
            ),
          ),
        );
        break;
      case DrawerType.latest:
        _homeController.add(
          HomeEvent.loadedAllListVideos(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              latestOffset: 1,
              categoryId: categoryId,
            ),
          ),
        );
        break;
      case DrawerType.onTrend:
        _homeController.add(
          HomeEvent.loadedAllListVideos(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              featuredOffset: 1,
              categoryId: categoryId,
            ),
          ),
        );
        break;
      case DrawerType.popular:
        _homeController.add(
          HomeEvent.loadedAllListVideos(
            argumentsAllListVideosData: ArgumentsAllListVideosData(
              favOffset: 1,
              categoryId: categoryId,
            ),
          ),
        );
        break;
    }
  }
}
