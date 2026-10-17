extension UpperCaseFirstLetter on String {
  String upperCaseFirstLetter() {
    return isEmpty ? this : this[0].toUpperCase() + substring(1);
  }
}
