import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/strings.dart';


const String _appStoreUrl =
    'itms-apps://apps.apple.com/us/app/id1531075216?mt=8';
const String _googlePlayUrl = '';
const String _freeDial = '';
const String androidAppId = '';
const String iOSAppId = '';

class AppLinkOpener {
  AppLinkOpener._();
  static Future<void> openMailAppForContact(BuildContext context) {
    final title = Uri.encodeComponent('');
    final contactMailUrl =
        'mailto:${Strings.contactMailAddress}?subject=$title';
    return _launchURL(
      contactMailUrl,
    );
  }

  static Future<void> openPhoneAppForContact() {
    return _launchURL(
      'tel:${Strings.contactPhoneNumber}',
    );
  }

  static Future<void> openPhoneAppForFreeDial() {
    return _launchURL(
      'tel:$_freeDial',
    );
  }

  static Future<void> showAppMarketStore() async {
    if (Platform.isIOS) {
      return _launchURL(_appStoreUrl);
    } else if (Platform.isAndroid) {
      return _launchURL(_googlePlayUrl);
    }
  }

  static Future<void> showMarketStore() async => LaunchReview.launch(
        androidAppId: androidAppId,
        iOSAppId: iOSAppId,
        writeReview: false,
      );

  static Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }
}
