
class ProfileUserData {
/*
{
  "user_id": 436664,
  "gender": 2,
  "first_name": "Chiên",
  "last_name": "Bùi",
  "email": "",
  "country_calling_code": 84,
  "phone": "344850761",
  "birthday": "2009-04-11T17:00:00.000Z"
} 
*/

  int? userId;
  int? gender;
  String? firstName;
  String? lastName;
  String? email;
  int? countryCallingCode;
  String? phone;
  String? birthday;

  ProfileUserData({
    this.userId,
    this.gender,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCallingCode,
    this.phone,
    this.birthday,
  });
  ProfileUserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    gender = json['gender']?.toInt();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    email = json['email']?.toString();
    countryCallingCode = json['country_calling_code']?.toInt();
    phone = json['phone']?.toString();
    birthday = json['birthday']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['gender'] = gender;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['country_calling_code'] = countryCallingCode;
    data['phone'] = phone;
    data['birthday'] = birthday;
    return data;
  }
}

class ProfileUser {
/*
{
  "status": "success",
  "message": "Success",
  "data": {
    "user_id": 436664,
    "gender": 2,
    "first_name": "Chiên",
    "last_name": "Bùi",
    "email": "",
    "country_calling_code": 84,
    "phone": "344850761",
    "birthday": "2009-04-11T17:00:00.000Z"
  }
} 
*/

  String? status;
  String? message;
  ProfileUserData? data;

  ProfileUser({
    this.status,
    this.message,
    this.data,
  });
  ProfileUser.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? ProfileUserData.fromJson(json['data']) : null;
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
