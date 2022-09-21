class ValidatorLogin {
  static bool isEmpty(String phone) {
    return phone.isEmpty ? true : false;
  }

  static bool isValidPhone(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  static bool isValidEmail(String email) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool isValidPassword(String password) {
    return password.length >= 8? true : false;
  }
}