import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_text_styles.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../home/bloc/home_bloc.dart';

enum DrawerType { allVideo, topVideo, latest, onTrend, popular }

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key, this.drawerType});
  final DrawerType? drawerType;

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {

  late final _homeController = BlocProvider.of<HomeBloc>(context, listen: false);

  @override
  void dispose() {
    sl.get<DashboardBloc>().add(const HideBottomNavEvent(isHiveBottomNav: false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Dimens.dimens_184,
      child: Padding(
        padding: const EdgeInsets.only(left: Dimens.dimens_16, top: Dimens.dimens_60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.icLogoAppBar,
              fit: BoxFit.cover,
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
            _itemDrawer(
              context,
              icon: Assets.icCamera,
              title: 'all_video'.tr(context),
              onTap: _onTapAllVideo,
              isSelected: widget.drawerType == DrawerType.allVideo,
            ),
            _itemDrawer(
              context,
              icon: Assets.icRank,
              title: 'top_video'.tr(context),
              onTap: _onTapTopVideo,
              isSelected: widget.drawerType == DrawerType.topVideo,
            ),
            _itemDrawer(
              context,
              icon: Assets.icWatch,
              title: 'latest'.tr(context),
              onTap: _onTapLatestVideo,
              isSelected: widget.drawerType == DrawerType.latest,
            ),
            _itemDrawer(
              context,
              icon: Assets.icTrend,
              title: 'on_trend'.tr(context),
              onTap: _onTapOnTrend,
              isSelected: widget.drawerType == DrawerType.onTrend,
            ),
            _itemDrawer(
              context,
              icon: Assets.icFire,
              title: 'popular'.tr(context),
              onTap: _onTapPopular,
              isSelected: widget.drawerType == DrawerType.popular,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapAllVideo() {
    final state = BlocProvider.of<DashboardBloc>(context).state;
    if (state is DrawerTypeState && state.drawerType == DrawerType.allVideo) {
      return;
    }
    sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.allVideo));
    _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
    Scaffold.of(context).closeDrawer();
  }

  void _onTapTopVideo() {
    final state = BlocProvider.of<DashboardBloc>(context).state;
    if (state is DrawerTypeState && state.drawerType == DrawerType.topVideo) {
      return;
    }
    sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.topVideo));
    _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
    Scaffold.of(context).closeDrawer();
  }

  void _onTapLatestVideo() {
    final state = BlocProvider.of<DashboardBloc>(context).state;
    if (state is DrawerTypeState && state.drawerType == DrawerType.latest) {
      return;
    }
    sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.latest));
    _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
    Scaffold.of(context).closeDrawer();
  }

  void _onTapOnTrend() {
    final state = BlocProvider.of<DashboardBloc>(context).state;
    if (state is DrawerTypeState && state.drawerType == DrawerType.onTrend) {
      return;
    }
    sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.onTrend));
    _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
    Scaffold.of(context).closeDrawer();
  }

  void _onTapPopular() {
    final state = BlocProvider.of<DashboardBloc>(context).state;
    if (state is DrawerTypeState && state.drawerType == DrawerType.popular) {
      return;
    }
    sl.get<DashboardBloc>().add(const DrawerTypeEvent(drawerType: DrawerType.popular));
    _homeController.add(const HomeEvent.selectedMenu(currentIndexMenu: 0));
    Scaffold.of(context).closeDrawer();
  }

  Widget _itemDrawer(
    BuildContext context, {
    void Function()? onTap,
    required String icon,
    required String title,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.cover,
              color: !isSelected
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.onInverseSurface,
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_13)),
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: !isSelected
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Theme.of(context).colorScheme.onInverseSurface,
                fontWeight: AppThemeData.medium,
                fontSize: AppTextStyles.fontSize_16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
