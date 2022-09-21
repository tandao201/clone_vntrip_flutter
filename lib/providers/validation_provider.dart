import 'package:clone_vntrip/validators/validator_login.dart';
import 'package:flutter/material.dart';
import '../models/login/request.dart';

class ValidInput with ChangeNotifier {
  final emptyUsernameError = "Số điện thoại hoặc email không để trống.";
  final usernameError = "Email hoặc số điện thoại không đúng định dạng.";
  final passwordError = "Mật khẩu phải chứa từ 8 kí tự trở lên.";
  final passwordEmpty = "Mật khẩu không để trống.";


  bool isEmptyUsername = false;
  bool isEmptyPass = false;
  bool isValidUsername = true;
  bool isValidPassword = true;
  String error = "";

  void checkInput(RequestLogin request) {
    // error = "";
    print(request.phone);
    print(request.password);
    if (ValidatorLogin.isEmpty(request.phone)) {
      print('user empty');
      isEmptyUsername = true;
      error = emptyUsernameError;
      notifyListeners();
    } else if (!ValidatorLogin.isValidPhone(request.phone) &&
        !ValidatorLogin.isValidEmail(request.phone)) {

      isValidUsername = false;
      error = usernameError;
      notifyListeners();
    } else if (ValidatorLogin.isEmpty(request.password)) {
      print('pass empty');
      isEmptyPass = true;
      error = passwordEmpty;
      notifyListeners();
    } else if (!ValidatorLogin.isValidPassword(request.password)) {
      print("valid pass....");
      isValidPassword = false;
      error = passwordError;
      notifyListeners();
    } else {
      isEmptyUsername = false;
      isEmptyPass = false;
      isValidUsername = true;
      isValidPassword = true;
      error = "";
      notifyListeners();
    }
  }
}
