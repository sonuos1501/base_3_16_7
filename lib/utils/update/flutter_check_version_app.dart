
// ignore_for_file: strict_raw_type, only_throw_errors, avoid_dynamic_calls, avoid_catches_without_on_clauses, inference_failure_on_function_invocation

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

typedef GetStoreVersionAndUrl = Future<StoreVersionAndUrl?> Function(String packageName);
typedef ShowUpdateDialog = void Function(BuildContext context, FlutterCheckVersionApp versionCheck);

class StoreVersionAndUrl {

  StoreVersionAndUrl(this.storeVersion, this.storeUrl);
  final String storeVersion;
  final String storeUrl;
}

String _country = 'us';

class FlutterCheckVersionApp {

  /// FlutterCheckVersionApp constructor
  ///
  /// optional packageName : uses package_info if not provided.
  /// optional packageVersion : uses package_info if not provided.
  /// optional getStoreVersionUrl : function for getting version and url from store. (too override default implementation)
  /// optional showUpdateDialog : function for displaying custom update dialog.
  /// optional country : for ios/mac version check (default: 'us').
  FlutterCheckVersionApp({
    this.packageName,
    this.packageVersion,
    this.getStoreVersionAndUrl,
    this.showUpdateDialog,
    this.country,
  });
  String? packageName;
  String? packageVersion;
  String? storeVersion;
  String? storeUrl;
  String? country;

  GetStoreVersionAndUrl? getStoreVersionAndUrl;
  ShowUpdateDialog? showUpdateDialog;

  /// check version from iOS/Android/Mac store and
  /// provide update dialog if update is available.
  Future checkVersion(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();

    packageName ??= packageInfo.packageName;
    packageVersion ??= packageInfo.version;
    _country = country ?? 'us';

    if (getStoreVersionAndUrl == null) {
      switch (Platform.operatingSystem) {
        case 'android':
          getStoreVersionAndUrl = _getAndroidStoreVersionAndUrl;
          break;
        case 'ios':
          getStoreVersionAndUrl = _getIOSStoreVersionAndUrl;
          break;
        case 'macos':
          getStoreVersionAndUrl = _getMacStoreVersionAndUrl;
          break;
        default:
          throw 'Platform ${Platform.operatingSystem} not supported.';
      }
    }

    final storeVersionAndUrl = await getStoreVersionAndUrl!(packageName!);
    if (storeVersionAndUrl != null) {
      storeVersion = storeVersionAndUrl.storeVersion;
      storeUrl = storeVersionAndUrl.storeUrl;

      if (hasUpdate) {
        showUpdateDialog ??= _showUpdateDialog;
        // ignore: use_build_context_synchronously
        showUpdateDialog!(context, this);
      }
    }
  }

  /// check if update is available
  bool get hasUpdate {
    if (packageVersion == null) {
      return false;
    }
    if (storeVersion == null) {
      return false;
    }
    return _shouldUpdate(packageVersion, storeVersion);
  }

  /// launch store for update
  Future launchStore() async {
    final url = storeUrl!;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future<StoreVersionAndUrl?> _getIOSStoreVersionAndUrl(String bundleId) async {
  final params = {'bundleId': bundleId, 'country': _country};
  final uri = Uri.https('itunes.apple.com', '/lookup', params);
  final resp = await http.get(uri);

  if (resp.statusCode == 200) {
    final j = json.decode(resp.body);
    final version = j['results'][0]['version'];
    final url = j['results'][0]['trackViewUrl'];
    return StoreVersionAndUrl(version, url);
  }

  return null;
}

Future<StoreVersionAndUrl?> _getAndroidStoreVersionAndUrl(
    String packageName,) async {
  final uri = Uri.https('play.google.com', '/store/apps/details',
      {'id': packageName, 'hl': 'en'},);

  final resp = await http.get(uri, headers: {
    'referer': 'http://www.google.com',
    'user-agent':
        'Mozilla/5.0 (Windows; U; WindowsNT 5.1; en-US; rv1.8.1.6) Gecko/20070725 Firefox/2.0.0.6',
  },);

  if (resp.statusCode == 200) {
    final doc = parse(resp.body);
    final url = 'https://play.google.com/store/apps/details?id=$packageName';

    try {
      final elements = doc.querySelectorAll('.hAyfc .BgcNfc');

      final cv =
          elements.firstWhere((element) => element.text == 'Current Version');
      final version = cv.nextElementSibling!.text;
      return StoreVersionAndUrl(version, url);
    } catch (_) {}
    try {
      final elements = doc.getElementsByTagName('script');

      for (final e in elements) {
        final match = RegExp('"(\\d+\\.\\d+\\.\\d+)"').firstMatch(e.text);
        if (match != null) {
          return StoreVersionAndUrl(match.group(1)!, url);
        }
      }
    } catch (_) {}

    try {
      final elements = doc.querySelectorAll('div');

      final cv =
          elements.firstWhere((element) => element.text == 'Current Version');
      final version = cv.nextElementSibling!.text;
      return StoreVersionAndUrl(version, url);
    } catch (_) {}
  }

  return null;
}

Future<StoreVersionAndUrl?> _getMacStoreVersionAndUrl(String bundleId) async {
  final params = {'bundleId': bundleId, 'country': _country};
  final uri = Uri.https('itunes.apple.com', '/lookup', params);
  final resp = await http.get(uri);

  if (resp.statusCode == 200) {
    final j = json.decode(resp.body);
    // print(j);
    final version = j['results'][0]['version'];
    final url = j['results'][0]['trackViewUrl'];
    return StoreVersionAndUrl(version, url);
  }

  return null;
}

bool _shouldUpdate(String? packageVersion, String? storeVersion) {
  if (packageVersion == storeVersion) {
    return false;
  }

  final arr1 = packageVersion!.split('.');
  final arr2 = storeVersion!.split('.');

  for (var i = 0; i < math.min(arr1.length, arr2.length); i++) {
    final v1 = int.tryParse(arr1[i]);
    final v2 = int.tryParse(arr2[i]);

    if (v1 == null || v2 == null) {
      if (arr2[i].compareTo(arr1[i]) > 0) {
        return true;
      }
    } else if (v2 > v1) {
      return true;
    }
  }

  return false;
}

void _showUpdateDialog(BuildContext context, FlutterCheckVersionApp versionCheck) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Update Available'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Do you want to update to ${versionCheck.storeVersion}?'),
            Text('(current version ${versionCheck.packageVersion})'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Update'),
          onPressed: () async {
            Navigator.of(context).pop();
            await versionCheck.launchStore();
          },
        ),
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
