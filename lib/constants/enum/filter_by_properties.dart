
enum FilterByProperties { views, subscribers, mostActive }

extension FilterByPropertiesType on FilterByProperties {
  String get key {
    switch (this) {
      case FilterByProperties.views:
        return 'views';
      case FilterByProperties.subscribers:
        return 'subscribers';
      case FilterByProperties.mostActive:
        return 'most_active';
    }
  }

  String get name {
    switch (this) {
      case FilterByProperties.views:
        return 'channel_mg3';
      case FilterByProperties.subscribers:
        return 'channel_mg4';
      case FilterByProperties.mostActive:
        return 'channel_mg5';
    }
  }
}
