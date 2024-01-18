
import '../../constants/strings.dart';

class ConvertAppName {
  const ConvertAppName._();

  static String appName(String packageName) {
    if (packageName.contains(Strings.packageNameOwnerApp)) {
      return Strings.ownerApp;
    } else if (packageName.contains(Strings.packageNamePartnerApp)) {
      return Strings.partnerApp;
    } else if (packageName.contains(Strings.packageNameResidentApp)) {
      return Strings.residentApp;
    } else if (packageName.contains(Strings.packageNameKanriApp)) {
      return Strings.kanriApp;
    }
    return Strings.empty;
  }
}
