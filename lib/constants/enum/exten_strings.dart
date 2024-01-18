
extension ExtenStrings on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    } else if (length == 1) {
      return toUpperCase();
    }
    return this[0].toUpperCase() + substring(1);
  }
}
