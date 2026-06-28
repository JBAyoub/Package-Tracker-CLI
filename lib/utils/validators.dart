class Validators {
  static bool isValid(String? key) {
    final regEx = RegExp(r'^[A-Z0-9]{32}$');

    if (key == null || key.isEmpty) {
      print("Key can't be empty or null ");
      return false;
    }
    if (!regEx.hasMatch(key)) {
      print(
        "The key you provided has the wrong the format \n please provide a correct 17TRACK API key",
      );
      return false;
    }
    return true;
  }

  bool validTrackNumber(String? number) {
    if (number == null || number.isEmpty) {
      print("Key can't be empty or null ");
      return false;
    }
    final trackingRegex = RegExp(r'^[A-Z0-9]{10,30}$');
    if (!trackingRegex.hasMatch(number)) {
      print(
        "The Tracking Number you provided has the wrong the format \n please provide a correct Tracking Number",
      );
      return false;
    }
    return true;
  }
}
