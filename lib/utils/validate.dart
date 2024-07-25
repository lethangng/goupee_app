class Validate {
  // static bool validateEmail(String email) {
  //   final RegExp emailRegex =
  //       RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  //   return emailRegex.hasMatch(email);
  // }

  static bool validatePassword(String password) {
    // final passwordRegex = RegExp(
    //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');

    final lowercase = RegExp(r'[a-z]');
    final uppercase = RegExp(r'[A-Z]');
    final number = RegExp(r'\d');
    final special = RegExp(r'\W');

    return lowercase.hasMatch(password) &&
        uppercase.hasMatch(password) &&
        number.hasMatch(password) &&
        special.hasMatch(password);
  }

  static bool validateVNPhone(String phone) {
    final RegExp phoneRegex = RegExp(r'^0[987531][0-9]{8}$');
    return phoneRegex.hasMatch(phone);
  }

  static bool checkNullEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }
}
