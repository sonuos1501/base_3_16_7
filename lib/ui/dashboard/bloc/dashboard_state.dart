part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.hideBottomNav({@Default(false) bool hideBottomNav}) = HideBottomNavState;
  const factory DashboardState.currentType({ @Default(DrawerType.allVideo) DrawerType drawerType}) = DrawerTypeState;
  const factory DashboardState.currentSelecteBottomNavigator({ @Default(0) int index}) = CurrentSelecteBottomNavigator;
}
