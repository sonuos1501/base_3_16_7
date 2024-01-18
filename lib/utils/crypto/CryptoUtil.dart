// ignore_for_file: file_names, avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:tuple/tuple.dart';

import '../Extends/StringExtend.dart';


class CryptoUtil{

  static String passwordCryptor = '';

  static String encrypt({required String plainText, String? password}) {
    final key = en.Key.fromUtf8(password ?? passwordCryptor);
    final iv = en.IV.fromLength(16);
    final encryptor = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    final encrypted = encryptor.encrypt(plainText.base64Encode(), iv: iv);
    return encrypted.base64;
  }

  static String decrypt({required String plainText, String? password}) {
    final key = en.Key.fromUtf8(password ?? passwordCryptor);
    final iv = en.IV.fromLength(16);
    final encryptor = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    return encryptor.decrypt64(plainText, iv: iv);
  }

  static String? encryptAESCryptoJS(String plainText, String passphrase) {
    try {
      final salt = genRandomWithNonZero(8);
      final keyndIV = deriveKeyAndIV(passphrase, salt);
      final key = en.Key(keyndIV.item1);
      final iv = en.IV(keyndIV.item2);

      final encrypter = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      final encryptedBytesWithSalt = Uint8List.fromList(createUint8ListFromString('Salted__') + salt + encrypted.bytes);
      return base64.encode(encryptedBytesWithSalt);
    } catch (error) {
      return null;
    }
  }

  static String? decryptAESCryptoJS(String encrypted, String passphrase) {
    try {
      final encryptedBytesWithSalt = base64.decode(encrypted);

      final encryptedBytes =
      encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      final keyndIV = deriveKeyAndIV(passphrase, salt);
      final key = en.Key(keyndIV.item1);
      final iv = en.IV(keyndIV.item2);

      final encrypter = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
      final decrypted = encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
      return decrypted;
    } catch (error) {
      return null;
    }
  }

  static Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
    final password = createUint8ListFromString(passphrase);
    var concatenatedHashes = Uint8List(0);
    var currentHash = Uint8List(0);
    var enoughBytesForKey = false;
    var preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      // int preHashLength = currentHash.length + password.length + salt.length;
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(
            currentHash + password + salt,);
      } else {
        preHash = Uint8List.fromList(
            password + salt,);
      }

      //currentHash =  md5.convert(preHash).bytes;
      currentHash = Uint8List.fromList(md5.convert(preHash.toList()).bytes)  ;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) {
        enoughBytesForKey = true;
      }
    }

    final keyBtyes = concatenatedHashes.sublist(0, 32);
    final ivBtyes = concatenatedHashes.sublist(32, 48);
    return Tuple2(keyBtyes, ivBtyes);
  }

  static Uint8List createUint8ListFromString(String s) {
    final ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  static Uint8List genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const randomMax = 245;
    final uint8list = Uint8List(seedLength);
    for (var i=0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax)+1;
    }
    return uint8list;
  }
}
