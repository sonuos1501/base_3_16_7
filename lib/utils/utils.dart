// ignore_for_file: file_names, depend_on_referenced_packages, library_private_types_in_public_api, prefer_single_quotes, type_annotate_public_apis, inference_failure_on_untyped_parameter, parameter_assignments, always_declare_return_types, inference_failure_on_function_return_type, avoid_catches_without_on_clauses, only_throw_errors, join_return_with_assignment, avoid_double_and_int_checks, avoid_slow_async_io, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

import '../constants/colors.dart';
import 'Extends/ColorExtends.dart';
import 'Extends/DoubleExtend.dart';
import 'Extends/StringExtend.dart';

export 'datetime/DateTimeUtil.dart';
export 'shared_pref/PreferUtil.dart';

typedef VoidOnAction = void Function();
typedef VoidOnActionInt = void Function(int value);

class Utils {
  static String getUuid() {
    return const Uuid().v4();
  }

  static Color hexToColor(String code) {
    //return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    return ColorExtends(code);
  }

  static bool stringNullOrEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static int getFirstVersionOS() {
    final osVersion = Platform.operatingSystemVersion;
    return osVersion.split('.').first.toInt()!;
  }

  //Làm tròn
  static double round(double val, int places) {
    final mod = pow(10.0, places);
    return (val * mod).round().toDouble() / mod;
  }

  static bool validEmailPhone(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (double.tryParse(value) != null) {
      return validateMobile(value);
    } else {
      return isEmail(value);
    }
  }

  static bool isEmail(String em) {
    const p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool validateMobile(String value) {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,500}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static bool checkNewVersionWithOldVersion({
    required String oldVersion,
    required String newVersion,
  }) {
    if (oldVersion.isEmpty || newVersion.isEmpty) {
      return false;
    }
    final arrayOld = oldVersion.split('.');
    final arrayNew = newVersion.split('.');
    var arrayCount = 0;
    if (arrayOld.isEmpty) {
      return false;
    }
    if (arrayNew.isEmpty) {
      return false;
    }
    if (arrayOld.length > arrayNew.length) {
      arrayCount = arrayNew.length;
    } else {
      arrayCount = arrayOld.length;
    }
    for (var i = 0; i < arrayCount; i++) {
      final numberOld = int.parse(arrayOld[i]);
      final numberNew = int.parse(arrayNew[i]);
      if (numberNew > numberOld) {
        return true;
      } else if (numberNew < numberOld) {
        return false;
      }
    }
    return false;
  }

  static String getUnitName(
    double? value, {
    isDetail = false, //show chi tiết về đơn vị hay không
  }) {
    if (value == null) {
      return '';
    }
    var b = ' B';
    var m = ' M';
    var k = ' K';
    var unit = ' ';
    if (isDetail) {
      b = ' Billion';
      m = ' Million';
      k = ' Thousand';
      unit = ' đ';
    }

    final price = value.toInt();
    var priceView = '';
    if (price >= 1000000000) {
      final priceNew = price / 1000000000;
      final priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$b";
    } else if (price >= 1000000) {
      final priceNew = price / 1000000;
      final priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$m";
    } else if (price >= 1000) {
      final priceNew = price / 1000;
      final priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$k";
    } else {
      priceView = "$price$unit";
    }
    return priceView;
  }

  static String getUnitDistance(double? value) {
    if (value == null) {
      return '';
    }
    const km = 'km';
    const m = 'm';

    final price = value.toInt();
    var priceView = '';
    if (price >= 1000) {
      final priceNew = price / 1000;
      final priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$km";
    } else {
      priceView = "$price$m";
    }
    return priceView;
  }

  static String doubleToString(dynamic value) {
    return value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
  }

  static String toLowerCaseNormalType(String value) {
    var text = value.toLowerCase();
    if (value.isNotEmpty) {
      final left = text.substring(0, 1).toUpperCase();
      final right = text.substring(1);
      text = left + right;
    }
    return text;
  }

  static String acronymString(String? text) //viết tắt
  {
    if (text == null) {
      return '';
    }
    if (text.length <= 1) {
      return text;
    }
    final listString = <String>[];
    final array = text.split(' ');
    for (final t in array) {
      if (t.isNotEmpty) {
        listString.add(t.substring(0, 1));
      }
    }
    return listString.join().trim().toUpperCase();
  }

  static Size textSize(
    String text,
    TextStyle style, {
    int maxLine = 1,
    double minWidth = 0,
    double maxWidth = double.infinity,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLine,
      textDirection: material.TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.size;
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);

    final parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static String getFullName(String? firstName, String? lastName) {
    lastName = lastName ?? '';
    firstName = firstName ?? '';
    final fullName = '${lastName.trim()} ${firstName.trim()}';
    return fullName.trim();
  }

  static String getInitials(String? nameString) {
    if (nameString == null || nameString.isEmpty) {
      return ' ';
    }

    final nameArray =
        nameString.replaceAll(RegExp(r'\s+\b|\b\s'), ' ').split(' ');
    final initials = (nameArray[0][0]) +
        (nameArray.length == 1 ? ' ' : nameArray[nameArray.length - 1][0]);

    return initials;
  }

  static void showToast(
    BuildContext context,
    String message, {
    bool status = true,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: status ? AppColors.green58C732 : AppColors.redC8160C,
      fontSize: 12,
    );
  }

  static void showToastCenter(
    BuildContext context,
    String message, {
    bool status = true,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: status ? AppColors.green58C732 : AppColors.redC8160C,
      fontSize: 12,
    );
  }

  static String intToPrice(int? price) {
    if (price == null) {
      return '0';
    }
    final oCcy = NumberFormat('#,###');
    final string = oCcy.format(price);
    return string.replaceAll(',', '.');
  }

  static String intToPriceDouble(dynamic price) {
    if (price == null) {
      return '';
    }
    final oCcy = NumberFormat('#,###');
    final string = oCcy.format(price);
    return string.replaceAll(',', '.');
  }

  static String intToAreaDouble(dynamic price) {
    if (price == null) {
      return '';
    }
    return NumberFormat.currency(locale: 'eu', decimalDigits: 2, symbol: '')
        .format(price)
        .replaceAll(',00', '');
    // final oCcy = NumberFormat("#,##0.00", "VN");
    // var string = oCcy.format(price);
    // return string;
  }

  static String getUrlInString(String text) {
    final urlRegExp = RegExp(
      r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?',
    );
    final matches = urlRegExp.allMatches(text);
    final url = matches.isEmpty
        ? ''
        : text.substring(matches.first.start, matches.first.end);
    return !url.contains('http') && url.isNotEmpty ? 'https://$url' : url;
  }

  static bool getTagInString(String text) {
    final urlRegExp = RegExp(r'\B@\w+');
    return urlRegExp.hasMatch(text);
  }

  static openURL(BuildContext context, String url) async {
    try {
      await launchURL(url);
    } catch (e) {
      showToast(context, e.toString(), status: false);
    }
  }

  static callPhoneNumber(BuildContext context, String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    try {
      await launchURL(url);
    } catch (e) {
      showToast(context, e.toString(), status: false);
    }
  }

  static String checkFileType(String fileType) {
//    switch (fileType){
//      case () :
//        break;
//    }
    return '';
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static launchURL(String url, {Map<String, String>? headers}) async {
    if (!url.contains('http')) {
      url = 'http://$url';
    }
    if (await canLaunchUrlString(url)) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

//
//  static String getYoutubeId(String url) {
//    print("Youtube Link: $url}");
//
//    if (url.contains("youtu.be")) {
//      var array = url.split("youtu.be/");
//      if (array.length > 1) {
//        print("Youtube Id: ${array[1]}");
//        return array[1];
//      }
//    }
//    var youtubeId = YoutubePlayer.convertUrlToId(url) ?? "";
//    print("Youtube Id: $youtubeId");
//    return youtubeId;
//  }

  //bỏ dấu tiếng việt
  static String nonUnicode(String text) {
    var textNew = text;
    final arr1 = [
      'á',
      'à',
      'ả',
      'ã',
      'ạ',
      'â',
      'ấ',
      'ầ',
      'ẩ',
      'ẫ',
      'ậ',
      'ă',
      'ắ',
      'ằ',
      'ẳ',
      'ẵ',
      'ặ',
      'đ',
      'é',
      'è',
      'ẻ',
      'ẽ',
      'ẹ',
      'ê',
      'ế',
      'ề',
      'ể',
      'ễ',
      'ệ',
      'í',
      'ì',
      'ỉ',
      'ĩ',
      'ị',
      'ó',
      'ò',
      'ỏ',
      'õ',
      'ọ',
      'ô',
      'ố',
      'ồ',
      'ổ',
      'ỗ',
      'ộ',
      'ơ',
      'ớ',
      'ờ',
      'ở',
      'ỡ',
      'ợ',
      'ú',
      'ù',
      'ủ',
      'ũ',
      'ụ',
      'ư',
      'ứ',
      'ừ',
      'ử',
      'ữ',
      'ự',
      'ý',
      'ỳ',
      'ỷ',
      'ỹ',
      'ỵ',
    ];
    final arr2 = [
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'd',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'e',
      'i',
      'i',
      'i',
      'i',
      'i',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'o',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'u',
      'y',
      'y',
      'y',
      'y',
      'y',
    ];

    for (var i = 0; i < arr1.length; i++) {
      textNew = textNew.replaceAll(arr1[i], arr2[i]);
      textNew =
          textNew.replaceAll(arr1[i].toUpperCase(), arr2[i].toUpperCase());
    }
    return textNew;
  }

  static String getUnitPrice(String price) {
    final arrayTachUnit = price.split(' ');
    if (arrayTachUnit.length > 1) {
      return arrayTachUnit[1];
    }
    return '';
  }

  static String showValueDouble(double value, int places) {
    final text = roundDouble(value, places).toString().replaceAll('.0', '');
    return text;
  }

  static double roundDouble(double value, int places) {
    final mod = pow(10.0, places);
    return (value * mod).round().toDouble() / mod;
  }

  static String decodePhone(String phoneNumber) {
    phoneNumber = phoneNumber.replaceRange(
      phoneNumber.length - 3,
      phoneNumber.length,
      '***',
    );
    return phoneNumber;
  }

  static String getFullPhoneWithCountryCode({
    required String countryCode,
    required String phoneNumber,
  }) {
    var phone = phoneNumber;
    if (phoneNumber.isNotEmpty) {
      final split = phoneNumber.substring(0, 1);
      if (split == '0') {
        phone = phoneNumber.substring(1, phoneNumber.length);
      }
    }
    return countryCode + phone;
  }

  static String getAvatarName(String name) {
    if (name.trim().isNotEmpty) {
      return name.substring(0, 1);
    }
    return '';
  }

  static Color getColorAvatarRandom(String name) {
    final listColor = {
      'a': '#FFC312',
      'b': '#C4E538',
      'c': '#12CBC4',
      'd': '#FDA7DF',
      'e': '#82589F',
      'f': '#F79F1F',
      'g': '#A3CB38',
      'h': '#1289A7',
      'i': '#D980FA',
      'j': '#B53471',
      'k': '#EE5A24',
      'l': '#009432',
      'm': '#0652DD',
      'n': '#9980FA',
      'o': '#833471',
      'p': '#EA2027',
      'q': '#006266',
      'r': '#1B1464',
      's': '#5758BB',
      't': '#FEA47F',
      'u': '#25CCF7',
      'v': '#EAB543',
      'w': '#55E6C1',
      '0': '#F97F51',
      '1': '#1B9CFC',
      '2': '#58B19F',
      '3': '#2C3A47',
      '4': '#B33771',
      '5': '#3B3B98',
      '7': '#182C61',
      '8': '#6D214F',
      '9': '#FC427B',
    };
    final charr = getAvatarName(name).toLowerCase();
    final hex = listColor[charr];
    if (hex == null || hex.isEmpty) {
      return hexToColor('FC427B');
    }
    return hexToColor(hex);
  }

  static Future<String?> getDeviceIdentifier() async {
    // String identifier;
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        //identifier = build.androidId; //UUID for Android
        return build.androidId;
      } else if (Platform.isIOS) {
        final build = await deviceInfoPlugin.iosInfo;
        // identifier = data.identifierForVendor; //UUID for iOS
        return build.identifierForVendor;
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    //print('identifier= ' + identifier);
    return null;
  }

  //kiểm tra chữ bắt đầu trong đoạn text: Ví dụ: check chữ SON có ở đầu câu ThuyYeuSon không
  static bool checkTextBegin(String? textBegin, String? textFull) {
    if (textBegin == null || textFull == null) {
      return false;
    }
    if (textBegin.length >= textFull.length) {
      return textBegin == textFull;
    }
    final cutTextFull = textFull.substring(0, textBegin.length);
    return textBegin == cutTextFull;
  }

  //kiểm tra text này có phải url không
  static bool isValidUrl(String url) {
    final validURL = Uri.parse(url).isAbsolute;
    return validURL;
  }

  //lấy random String theo số lượng ký tự
  static String getRandomString({required int length}) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  static String getFileExtension({required String fileName}) {
    return '';
  }

  static String getFileNameInPath({required String path}) {
    return p.basename(path);
  }

  static _UserNameInfo getFirstLastName(String fullName) {
    final info = _UserNameInfo();
    if (fullName.isNotEmpty) {
      final array = fullName.split(' ');
      if (array.length <= 1) {
        info
          ..firstName = fullName.trim()
          ..lastName = '';
      } else {
        info
          ..firstName = array[array.length - 1]
          ..lastName = fullName
              .substring(0, fullName.length - info.firstName.length)
              .trim();
      }
    }
    return info;
  }

  static String getYoutubeId({required String url}) {
    if (url.contains('youtu.be')) {
      final array = url.split('youtu.be/');
      if (array.length > 1) {
        debugPrint('Youtube Id: ${array[1]}');
        return array[1];
      }
    }
    final youtubeId = _convertUrlToId(url) ?? '';
    return youtubeId;
  }

  static String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains('http') && (url.length == 11)) {
      return url;
    }
    if (trimWhitespaces) {
      url = url.trim();
    }

    for (final exp in [
      RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$',
      ),
      RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$',
      ),
      RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$'),
    ]) {
      final match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    }

    return null;
  }

  static String convertVNtoEN(String text) {
    const vietnamese = 'aAeEoOuUiIdDyY^^';
    final vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ'),
      RegExp(r'\u0300|\u0301|\u0303|\u0309|\u0323'),
      RegExp(r'\u02C6|\u0306|\u031B'),
    ];

    var result = text;
    for (var i = 0; i < vietnamese.length; ++i) {
      result = result.replaceAll(vietnameseRegex[i], vietnamese[i]);
    }
    result = result.replaceAll('^', '');
    return result;
  }

  static double toPrecision(double d, int i) {
    final mod = pow(10.0, i) as double;
    return (d * mod).round().toDouble() / mod;
  }

  //lấy list param trong url get
  static Map<String, String>? getParamInUrl({required String? url}) {
    if (url == null) {
      return null;
    }
    final uri = Uri.dataFromString(url);
    if (uri.queryParameters.keys.isEmpty) {
      return null;
    }
    return uri.queryParameters;
  }

  //lấy giá trị trong param url get
  static String? getValueInParamUrl({
    required String? url,
    required String key,
  }) {
    if (url == null) {
      return null;
    }
    final param = getParamInUrl(url: url);
    if (param != null) {
      return param[key];
    }
    return null;
  }

  //lấy text quá số ký tự
  static String? getTextOverWithLength({
    required String? text,
    required int length,
  }) {
    if (text != null) {
      if (text.trim().length < length + 1) {
        return text;
      } else {
        return '${text.trim().substring(0, length)}...';
      }
    }
    return null;
  }

  //chuyển đổi file sang base 64
  static Future<String> convertFileToBase64(String? path) async {
    if (path == null || path == '') {
      return '';
    }
    try {
      if (path.contains('http://') || path.contains('https://')) {
        return path;
      }
      // to match file <5Mb
      //File file = await getFileMiniSize(path);
      final file = File(path);
      final bytes = await file.readAsBytes();
      final img64 = base64UrlEncode(bytes);
      final type = p.extension(file.path).split('.')[1];
      final imgCode = 'data:image/$type;base64,$img64';
      return imgCode;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  // To get file in mini size
  static Future<File> getFileMiniSize(String path) async {
    try {
      final file = File(path);
      final sizeInBytes = file.lengthSync();
      final sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb < 4) {
        return file;
      }
      var percentQuality = ((4 / sizeInMb) * 100).round();
      final properties = await FlutterNativeImage.getImageProperties(file.path);
      File result;
      if ((properties.width ?? 1025) > 1024) {
        result = await FlutterNativeImage.compressImage(
          file.path,
          quality: percentQuality,
          targetWidth: 1024,
          targetHeight: (properties.height! * 1024 / properties.width!).round(),
        );
      } else {
        result = await FlutterNativeImage.compressImage(file.path, quality: 80);
      }
      var sizeResult = result.lengthSync() / (1024 * 1024);
      if (sizeResult < 4) {
        return result;
      }
      while (sizeResult > 4) {
        percentQuality = ((4 / sizeResult) * 100).round();
        result = await FlutterNativeImage.compressImage(
          file.path,
          quality: percentQuality,
          percentage: 80,
        );
        sizeResult = (result.lengthSync()) / (1024 * 1024);
      }
      return result;
    } catch (e, t) {
      debugPrint(t.toString());
      return File(path);
    }
  }

  //thoát số màn hình
  static void popCountScreen(
    BuildContext context,
    int countScreen, {
    Object? result,
  }) {
    var count = 0;
    while (count < countScreen) {
      Navigator.of(context).pop(result);
      count++;
    }
  }

  //tắt bàn phím
  static void onHideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //chọn polygon
  static bool isGeoPointInPolygon(LatLng l, List<LatLng> polygon) {
    var isInPolygon = false;

    for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      if ((((polygon[i].latitude <= l.latitude) &&
                  (l.latitude < polygon[j].latitude)) ||
              ((polygon[j].latitude <= l.latitude) &&
                  (l.latitude < polygon[i].latitude))) &&
          (l.longitude <
              (polygon[j].longitude - polygon[i].longitude) *
                      (l.latitude - polygon[i].latitude) /
                      (polygon[j].latitude - polygon[i].latitude) +
                  polygon[i].longitude)) {
        isInPolygon = !isInPolygon;
      }
    }
    return isInPolygon;
  }

  static String formatMoney(dynamic money) {
    if (money == null) {
      return '';
    } else if (money is String) {
      if (money.toInt() != null) {
        return intToPriceDouble(money.toInt()).replaceAll('.', ',');
      } else if (money.toDouble() != null) {
        return intToPriceDouble(money.toDouble()).replaceAll('.', ',');
      }
    } else if (money is double) {
      return intToPriceDouble(money).replaceAll('.', ',');
    } else if (money is int) {
      return intToPriceDouble(money).replaceAll('.', ',');
    }
    return '0';
  }

  static String convertMoney(
    double? value, {
    isDetail = false, //show chi tiết về đơn vị hay không
  }) {
    if (value == null) {
      return '';
    }
    var b = ' tỷ';
    var m = ' tr';
    var k = ' ng';
    var unit = ' ';
    if (isDetail) {
      b = ' tỷ';
      m = ' triệu';
      k = ' nghìn';
      unit = ' đ';
    }

    final price = value.toInt();
    var priceView = '';
    if (price >= 1000000000) {
      final priceNew = price / 1000000000;
      final priceString = priceNew.toRound(2).toStringRound();
      priceView = "$priceString$b";
    } else if (price >= 1000000) {
      final priceNew = price / 1000000;
      final priceString = priceNew.toRound(2).toStringRound();
      priceView = "$priceString$m";
    } else if (price >= 1000) {
      final priceNew = price / 1000;
      final priceString = priceNew.toRound(2).toStringRound();

      priceView = "$priceString$k";
    } else {
      priceView = "$price$unit";
    }
    return priceView;
  }

  static void share({
    String? title,
    String? subject,
  }) {
    Share.share(title ?? '', subject: subject ?? 'SON');
  }

  static void copy(BuildContext context, String content, {String? message}) {
    FlutterClipboard.copy(content)
        .then((value) => showToast(context, message ?? 'Sao chép thành công'));
  }

  static String getTimeAgo(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return timeago.format(dateTime, locale: 'vi_short');
  }

  //Tạo file
  static Future<File> creatFile(String fileName) async {
    final file = File('localPath$fileName');
    return file;
  }

  static Future<String> get localPath async {
    String pathss;
    if (Platform.isAndroid) {
      final temDirkAndroid = await getExternalStorageDirectory();
      pathss = temDirkAndroid!.path;
    } else {
      final temDirkIos = await getApplicationDocumentsDirectory();
      pathss = temDirkIos.path;
    }
    return pathss;
  }

  static Future<File> localFile(String fileName) async {
    final path = await localPath;
    return File('$path$fileName');
  }

  //Xoá file
  static Future<int> deleteFile(String fileName) async {
    try {
      final file = await localFile(fileName);
      await file.delete();
    } catch (e) {
      return 0;
    }
    return 1;
  }

  //Kiểm tra file có tồn tại chưa
  static Future<bool> checkFileExist(String fileName) async {
    try {
      if (await Directory('localPath$fileName').exists()) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('e  eee $e');
      return false;
    }
  }

  //Đọc file
  static Future<String> readFile(String fileName) async {
    try {
      final file = await localFile(fileName);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      debugPrint('readErrrrrrrrrrrrrrrrrrrrrr  $e');
      return '';
    }
  }

  //Viết dữ liệu vào file
  static Future<bool> writeFile(File file, String text) async {
    try {
      await file.writeAsString(text);
      return true;
    } catch (e) {
      debugPrint('readErrrrrrrrrrrrrrrrrrrrrr  $e');
      return false;
    }
  }

  //Chuyển đổi vị trí 2 phần tử trong danh sách
  static List<T> switchPositions<T>(List<T> list, int index1, int index2) {
    final element = list.removeAt(index1);
    list.insert(index2, element);
    return list;
  }
}

class _UserNameInfo {
  String firstName = '';
  String lastName = '';
}
