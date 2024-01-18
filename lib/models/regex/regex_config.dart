class RegexConfig {

  final String pattern;
  final String errorText;

  RegexConfig({ this.pattern = r'.*', this.errorText = '' });

  RegExp get getRegExp => RegExp(pattern);

  String get getTextError => errorText;

}
