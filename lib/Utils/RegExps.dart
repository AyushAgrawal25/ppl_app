class RegExpsCollections {
  static RegExp email =
      RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
  static RegExp alphaNumeric = RegExp(r"^[a-zA-Z0-9]*$");
  static RegExp decimal = RegExp(r"[\d.]");
  static RegExp onlyAlphabets = RegExp(r'^[a-zA-Z]*$');
  static RegExp userName = RegExp(r"^[A-Za-z][A-Za-z0-9]*$");
  static RegExp oneUpperCase = RegExp(r'[ A-Z ]');
  static RegExp oneLowerCase = RegExp(r'[ a-z ]');
  static RegExp oneDigit = RegExp(r'[ 0-9 ]');
  static RegExp oneSpecialCharacter =
      RegExp(r'(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\])');
  static RegExp number = RegExp(r"^[0-9]*$");
}
