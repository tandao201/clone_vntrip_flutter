class UserInfo {
  String? firstName, lastName, phone, email, dateOfBirth, category;
  bool? gender, isValid, isFirstPick;

  UserInfo({this.firstName,this.lastName, this.phone, this.email, this.dateOfBirth, this.category,
    this.gender=true, this.isValid=false, this.isFirstPick=true});
}