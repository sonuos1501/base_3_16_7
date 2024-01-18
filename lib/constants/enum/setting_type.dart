enum ESettingsType { general }

extension SettingsType on ESettingsType {
  String get name {
    switch (this) {
      case ESettingsType.general:
        return 'general';
    }
  }
}
