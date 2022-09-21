class ResponseLoginData {
/*
{
  "access_token": "3aomXqvxlLB8tb4c4bqXecA2hkUjIN",
  "refresh_token": "2H4Yj9EhkXPvqXvgEeDaJaEbiDNSlP",
  "expires_in": 604800,
  "scope": "read write",
  "token_type": "Bearer"
} 
*/

  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  String? tokenType;

  ResponseLoginData({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.tokenType,
  });
  ResponseLoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token']?.toString();
    refreshToken = json['refresh_token']?.toString();
    expiresIn = json['expires_in']?.toInt();
    scope = json['scope']?.toString();
    tokenType = json['token_type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    return data;
  }
}

class ResponseLogin {
/*
{
  "status": "success",
  "message": "Success",
  "data": {
    "access_token": "3aomXqvxlLB8tb4c4bqXecA2hkUjIN",
    "refresh_token": "2H4Yj9EhkXPvqXvgEeDaJaEbiDNSlP",
    "expires_in": 604800,
    "scope": "read write",
    "token_type": "Bearer"
  }
} 
*/

  String? status;
  String? message;
  ResponseLoginData? data;

  ResponseLogin({
    this.status,
    this.message,
    this.data,
  });
  ResponseLogin.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? ResponseLoginData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
