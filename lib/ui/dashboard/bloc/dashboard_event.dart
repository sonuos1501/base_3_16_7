part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.hideBottomNav({@Default(false) bool isHiveBottomNav}) = HideBottomNavEvent;
  const factory DashboardEvent.selectedTypeVideo({DrawerType? drawerType}) = DrawerTypeEvent;
  const factory DashboardEvent.selectedItemBottomNavigator({ required int index }) = SelectedItemBottomNavigator;
}
