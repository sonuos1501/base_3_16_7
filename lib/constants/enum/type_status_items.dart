import 'package:base_3_16_7/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

enum TypeStatusItems { hot, live, top, sale }

enum MessageStatus { delivered, error, seen, sending, sent }

enum MessageType {
  audio,
  custom,
  file,
  image,
  system,
  text,
  unsupported,
  video
}

extension ExTypeStatusItems on TypeStatusItems {
  String text(BuildContext context) {
    switch (this) {
      case TypeStatusItems.hot:
        return 'hot'.tr(context);
      case TypeStatusItems.live:
        return 'live'.tr(context);
      case TypeStatusItems.top:
        return 'top'.tr(context);
      case TypeStatusItems.sale:
        return 'sale'.tr(context);
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case TypeStatusItems.hot:
        return Theme.of(context).colorScheme.primary;
      case TypeStatusItems.live:
        return Theme.of(context).colorScheme.outline;
      case TypeStatusItems.top:
        return Theme.of(context).colorScheme.secondary;
      case TypeStatusItems.sale:
        return Theme.of(context).colorScheme.outline;
    }
  }
}
