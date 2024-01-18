// ignore_for_file: file_names, strict_raw_type, avoid_positional_boolean_parameters

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../crypto/CryptoUtil.dart';

class PreferUtil {
  static String keySecure = 'p@123';

  static Future<bool> checkKey(String key, {bool isSecure = false, String? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //Int

  static Future createInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      await prefs.setInt(key, intValue);
    }
  }

  static Future setInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, intValue);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key);
    return value;
  }

  //remove
  static Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  //Double
  static Future createDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      await prefs.setDouble(key, doubleValue);
    }
  }

  static Future setDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, doubleValue);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getDouble(key);
    return value;
  }

  //Boolean
  static Future createBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      await prefs.setBool(key, boolValue);
    }
  }

  static Future setBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, boolValue);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key);
    return value;
  }

  //String
  static Future createString(String key, String stringValue, {bool isSecure = false, String? userId}) async {
    final keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(keyNew)) {
      final valueNew = _valueEncrypt(key, stringValue, isSecure: isSecure, userId: userId);
      await prefs.setString(keyNew, valueNew ?? '');
    }
  }

  static Future setString(String key, String stringValue, {bool isSecure = false, String? userId}) async {
    final keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    final valueNew = _valueEncrypt(key, stringValue, isSecure: isSecure, userId: userId);
    await prefs.setString(keyNew, valueNew ?? '');
  }

  static Future<String> getString(String key, {bool isSecure = false, String? userId}) async {
    final keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(keyNew) ?? '';
    final valueNew = _valueDecrypt(key, value, isSecure: isSecure, userId: userId);
    return valueNew ?? '';
  }

  //List String
  static Future createListString(String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      await prefs.setStringList(key, listStringValue);
    }
  }

  static Future setListString(String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, listStringValue);
  }

  static Future<List<String>> getListString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList(key) ?? <String>[];
    return value;
  }

  static String _getKey(String key, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      final keyString = "k_$keySecure${userId ?? ""}$key";
      return 's_${md5.convert(utf8.encode(keyString))}';
    }
    return key;
  }

  static String _getKeyCrypt(String key, {String? userId = ''}) {
    final keyString = "$keySecure${userId ?? ""}$key";
    return 'k_${md5.convert(utf8.encode(keyString))}';
  }

  static String? _valueEncrypt(String key, String stringValue, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      return CryptoUtil.encryptAESCryptoJS(stringValue, _getKeyCrypt(key, userId: userId));
    }
    return stringValue;
  }

  static String? _valueDecrypt(String key, String stringValue, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      return CryptoUtil.decryptAESCryptoJS(stringValue, _getKeyCrypt(key, userId: userId));
    }
    return stringValue;
  }
}
