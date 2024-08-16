extension UpperCaseFirstLetter on String {
  String upperCaseFirstLetter() {
    return this[0].toUpperCase() + replaceFirst(RegExp(this[0]), "");
  }
}
