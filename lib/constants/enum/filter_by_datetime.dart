
enum FilterByDatetime { allTime, today, thisWeek, thisMonth, thisYear }

extension FilterByDatetimeType on FilterByDatetime {
  String get key {
    switch (this) {
      case FilterByDatetime.allTime:
        return 'all_time';
      case FilterByDatetime.today:
        return 'today';
      case FilterByDatetime.thisWeek:
        return 'this_week';
      case FilterByDatetime.thisMonth:
        return 'this_month';
      case FilterByDatetime.thisYear:
        return 'this_year';
    }
  }

  String get name {
    switch (this) {
      case FilterByDatetime.allTime:
        return 'channel_mg6';
      case FilterByDatetime.today:
        return 'channel_mg7';
      case FilterByDatetime.thisWeek:
        return 'channel_mg8';
      case FilterByDatetime.thisMonth:
        return 'channel_mg9';
      case FilterByDatetime.thisYear:
        return 'channel_mg10';
    }
  }
}
