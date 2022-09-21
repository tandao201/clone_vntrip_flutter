import 'dart:convert';
import 'package:clone_vntrip/models/login/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clone_vntrip/models/login/request.dart';
import 'package:clone_vntrip/models/login/response.dart';
import 'package:clone_vntrip/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/login/detail_account.dart';
import '../models/login/loyalties.dart';

class LoginProvider with ChangeNotifier {

  final AUTH_TOKEN = 'auth_token';
  final REFRESH_TOKEN = 'refresh_token';
  final USERNAME = 'username';

  ResponseLogin? responseLogin;
  ResponseLoginData? responseLoginData;
  RequestLogin? requestLogin;
  DetailAccount? accountInfo;
  ProfileUser? profileUser;
  Loyalties? loyalties;
  String? authToken;
  String? refreshToken;

  Future<void> login(RequestLogin requestLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    requestLogin.phone = '+84${requestLogin.phone.substring(1)}';
    this.requestLogin = requestLogin;
    try {
      http.Response response = await LoginService.postLogin(requestLogin);
      if (response.statusCode == 200) {
        print('status: ${response.statusCode}');
        responseLogin = ResponseLogin.fromJson(json.decode(response.body));
        print(responseLogin!.message);
        prefs.setString(AUTH_TOKEN, responseLogin!.data!.accessToken!);
        prefs.setString(REFRESH_TOKEN, responseLogin!.data!.refreshToken!);
        prefs.setString(USERNAME, requestLogin.phone);
        notifyListeners();
      } else {
        print('failure');
      }
    } catch (exception) {
      print('Exception call Api: ${exception.toString()}');
    }
  }

  Future<void> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AUTH_TOKEN)) {
      authToken = prefs.getString(AUTH_TOKEN);
      print("Access token1: $authToken");
      notifyListeners();
    } else {
      authToken = '';
    }

    if (prefs.containsKey(REFRESH_TOKEN)) {
      refreshToken = prefs.getString(REFRESH_TOKEN);
      print("Refresh token1: $refreshToken");
      notifyListeners();
    }

    if (prefs.containsKey(USERNAME)) {
      String? username = prefs.getString(USERNAME);
      requestLogin = RequestLogin(phone: username ?? "", password: "");
      print("Refresh token1: $refreshToken");
      notifyListeners();
    }

    if (authToken!=null){
      print('Auth token null');
      resetToken();
    }
  }

  void resetToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (authToken != null) {
        var data = await LoginService.postRefreshToken(refreshToken!);
        responseLoginData = ResponseLoginData.fromJson(json.decode(data));
        prefs.setString(REFRESH_TOKEN, responseLoginData!.refreshToken!);
        prefs.setString(AUTH_TOKEN, responseLoginData!.accessToken!);
        print("Refresh token after refresh: $refreshToken");
      }
    } catch (e) {
      responseLoginData = null;
    }
  }

  Future<void> initSplash() async {
    print('Init splash...');
    Future.delayed(const Duration(seconds: 2));
    if (authToken==null){
      await getAuthToken();
      return ;
    }
  }

  void clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_TOKEN, '');
    print("Auth token aften reset: ${prefs.getString(AUTH_TOKEN)}");
  }

  Future<void> detailAccount() async {

    try {
      print("Auth token $authToken");
      http.Response response = await LoginService.accountDetail(authToken!);
      if (response.statusCode == 200) {
        print('status: ${response.statusCode}');
        accountInfo = DetailAccount.fromJson(json.decode(response.body));
        print("Data call detail account ${accountInfo!.message}");
        print("Data call detail account ${accountInfo!.data!.userName}");
        notifyListeners();
      } else {
        print('Data call detail account failure');
      }
    } catch (exception) {
      print('Exception call detail user Api: ${exception.toString()}');
    }
  }

  Future<void> getProfileUser() async {

    try {
      print("Auth token $authToken");
      http.Response response = await LoginService.getProfileUser(authToken!);
      if (response.statusCode == 200) {
        print('status: ${response.statusCode}');
        profileUser = ProfileUser.fromJson(json.decode(response.body));
        print("Data call profile account ${profileUser!.message}");
        print("Data call profile account ${profileUser!.data!.userId}");
        notifyListeners();
      } else {
        print('Data call detail account failure');
      }
    } catch (exception) {
      print('Exception call detail user Api: ${exception.toString()}');
    }
  }

  Future<void> getLoyalties() async {
    try {
      http.Response response = await LoginService.getLoyalties();
      if (response.statusCode == 200) {
        print('status: ${response.statusCode}');
        loyalties = Loyalties.fromJson(json.decode(response.body));
        print("Data call loyalties ${accountInfo!.message}");
        print("Data call loyalties ${loyalties!.data![0]!.programNameVi}");
        notifyListeners();
      } else {
        print('Data call loyalties failure');
      }
    } catch (exception) {
      print('Exception call loyalties Api: ${exception.toString()}');
    }
  }
}