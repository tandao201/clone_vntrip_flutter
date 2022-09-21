import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login/request.dart';

class LoginService {
  static const url =
      'https://test-micro-services.vntrip.vn/core-user-service/auth/login/phone';

  static const urlRefreshToken =
      'https://test-services.vntrip.vn/vntrip/oauth2/token/';

  static const urlDetailAccount =
      'https://test-micro-services.vntrip.vn/v2-user/loyalties/membership-account/detail?program_id=3e72fb2d-a2c6-4ec2-b6a7-0e19be9c2d80';

  static const urlLoyalties =
      'https://test-micro-services.vntrip.vn/v2-user/loyalties/active';

  static const urlProfile =
      'https://test-micro-services.vntrip.vn/core-user-service/person/profile';

  static Future<http.Response> postLogin(RequestLogin requestLogin) async {
    return http.post(Uri.parse(url), body: requestLogin.toJson(), headers: {
      'Accept': 'application/json'
    }).then((http.Response response) => response);
  }

  static Future<dynamic> postRefreshToken(String refreshToken) async {
    final Uri uri = Uri.parse(urlRefreshToken);
    final response = await http.post(
      uri,
      body: {
        "refresh_token": refreshToken,
        "client_id": "16GuKzV8K1@92YcLg85uR5ku;peVriRZSn!1.UTh",
        "client_secret": "TCuMmpT!EGz5UT7GE3D?s-ikA5i0sCV2pI7cFYqc!0c;z1oIyCeLsVb_ZDRdI7KOg4Pem7XKz4UU0yJ2K37I5;3Sp2UVw!tNK-ps4vaguqr09MopDwB_7larJWAmXHyv",
        "grant_type": "refresh_token"
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    return response.body;
  }

  static Future<http.Response> accountDetail(String token) async {
    return http.get(Uri.parse(urlDetailAccount),
        headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((http.Response response) => response);
  }

  static Future<http.Response> getProfileUser(String token) async {
    return http.get(Uri.parse(urlProfile),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).then((http.Response response) => response);
  }

  static Future<http.Response> getLoyalties() async {
    return http.get(Uri.parse(urlLoyalties)).then((http.Response response) => response);
  }
}
