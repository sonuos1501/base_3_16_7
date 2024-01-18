import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/ui/dashboard/components/drawer.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const _Initial()) {
    on<HideBottomNavEvent>(_handleHideDrawer);
    on<DrawerTypeEvent>(_handleSelectTypeVideo);
    on<SelectedItemBottomNavigator>(_selectedItemBottomNavigator);
  }

  var _currentType = DrawerType.allVideo;

  void _handleHideDrawer(
    HideBottomNavEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(HideBottomNavState(hideBottomNav: event.isHiveBottomNav));
    emit(DrawerTypeState(drawerType: _currentType));

    return;
  }

  void _handleSelectTypeVideo(
    DrawerTypeEvent event,
    Emitter<DashboardState> emit,
  ) {
    if (event.drawerType != _currentType) {
      _currentType = event.drawerType ?? DrawerType.allVideo;
    }
    emit(DrawerTypeState(drawerType: _currentType));
    return;
  }

  Future<void> _selectedItemBottomNavigator(SelectedItemBottomNavigator event, Emitter<DashboardState> emit) async {
    return emit(DashboardState.currentSelecteBottomNavigator(index: event.index));
  }
}
