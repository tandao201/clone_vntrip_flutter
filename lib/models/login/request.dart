
class RequestLogin {
  String phone;
  String password;

  RequestLogin({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}