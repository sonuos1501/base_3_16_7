

import '../../models/regex/regex_config.dart';

abstract class RegexConstant {
  static RegexConfig none = RegexConfig(pattern: r'.{0,}', errorText: 'input_mg2');

  static RegexConfig notEmpty = RegexConfig(pattern: r'.{1,}', errorText: 'input_mg3');

  static RegexConfig notEmptyChoose = RegexConfig(pattern: r'.{1,}', errorText: 'input_mg4');

  static RegexConfig maxLength = RegexConfig(pattern: r'^.{1,50}$', errorText: 'input_mg5');

  static RegexConfig phone = RegexConfig(pattern: r'(^(?:[+])?[0-9]{10,12}$)', errorText: 'input_mg6');

  static RegexConfig email = RegexConfig(pattern: r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$', errorText: 'input_mg7');

  static RegexConfig password = RegexConfig(
    pattern: r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{0,20}$',
    errorText: 'input_mg8',
  );

  static RegexConfig passwordSecurity = RegexConfig(
    pattern: r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,12}$',
    errorText: 'input_mg9',
  );

  static RegexConfig passwordTransaction = RegexConfig(pattern: r'^\d{6,6}$', errorText: 'input_mg10');

  static RegexConfig idCardNumber = RegexConfig(
    pattern: r'^\d{9,9}(\d{3,3})?$',
    errorText: 'input_mg11',
  );

  static RegexConfig integerNotZero = RegexConfig(
    pattern: r'^0*[1-9][0-9]*$',
    errorText: 'input_mg12',
  );

  static bool isYouTubeLink(String url) {
    final regex = RegExp(
      r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$',
    );
    return regex.hasMatch(url);
  }
}
