
class DetailAccountDataNextExpiringPoints {

DetailAccountDataNextExpiringPoints.fromJson(Map<String, dynamic> json) {
}
Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  return data;
}
}

class DetailAccountData {
/*
{
  "id": 365233,
  "member_id": "864095672",
  "program_id": "3e72fb2d-a2c6-4ec2-b6a7-0e19be9c2d80",
  "user_id": 436664,
  "membership_status": "ACTIVE",
  "current_level": 1,
  "previous_level": null,
  "is_blacklisted": false,
  "current_level_date": "2021-04-12T02:37:14.719Z",
  "previous_level_date": null,
  "membership_since": "2021-04-12T02:37:14.719Z",
  "updated_at": "2022-06-01T08:00:00.424Z",
  "available_point": 0,
  "total_gained_point": 7560,
  "used_point": 0,
  "pending_point": 0,
  "expired_point": 7560,
  "account_lifetime_value": null,
  "qualifying_period_from": "2021-04-12T02:37:18.765Z",
  "log_data": null,
  "current_level_expires_at": null,
  "level_name": "Hạng Chuẩn",
  "level_image": "https://test-statics.vntrip.vn/uploads/loyalty_program/20180710_483500_Standardlogo.png",
  "card_image_url": "https://test-statics.vntrip.vn/uploads/loyalty_program/20180710_418300_Standard.png",
  "user_name": "Bùi Chiên",
  "next_expiring_points": {},
  "membership_card": null
}
*/

  int? id;
  String? memberId;
  String? programId;
  int? userId;
  String? membershipStatus;
  int? currentLevel;
  String? previousLevel;
  bool? isBlacklisted;
  String? currentLevelDate;
  String? previousLevelDate;
  String? membershipSince;
  String? updatedAt;
  int? availablePoint;
  int? totalGainedPoint;
  int? usedPoint;
  int? pendingPoint;
  int? expiredPoint;
  String? accountLifetimeValue;
  String? qualifyingPeriodFrom;
  String? logData;
  String? currentLevelExpiresAt;
  String? levelName;
  String? levelImage;
  String? cardImageUrl;
  String? userName;
  DetailAccountDataNextExpiringPoints? nextExpiringPoints;
  String? membershipCard;

  DetailAccountData({
    this.id,
    this.memberId,
    this.programId,
    this.userId,
    this.membershipStatus,
    this.currentLevel,
    this.previousLevel,
    this.isBlacklisted,
    this.currentLevelDate,
    this.previousLevelDate,
    this.membershipSince,
    this.updatedAt,
    this.availablePoint,
    this.totalGainedPoint,
    this.usedPoint,
    this.pendingPoint,
    this.expiredPoint,
    this.accountLifetimeValue,
    this.qualifyingPeriodFrom,
    this.logData,
    this.currentLevelExpiresAt,
    this.levelName,
    this.levelImage,
    this.cardImageUrl,
    this.userName,
    this.nextExpiringPoints,
    this.membershipCard,
  });
  DetailAccountData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    memberId = json['member_id']?.toString();
    programId = json['program_id']?.toString();
    userId = json['user_id']?.toInt();
    membershipStatus = json['membership_status']?.toString();
    currentLevel = json['current_level']?.toInt();
    previousLevel = json['previous_level']?.toString();
    isBlacklisted = json['is_blacklisted'];
    currentLevelDate = json['current_level_date']?.toString();
    previousLevelDate = json['previous_level_date']?.toString();
    membershipSince = json['membership_since']?.toString();
    updatedAt = json['updated_at']?.toString();
    availablePoint = json['available_point']?.toInt();
    totalGainedPoint = json['total_gained_point']?.toInt();
    usedPoint = json['used_point']?.toInt();
    pendingPoint = json['pending_point']?.toInt();
    expiredPoint = json['expired_point']?.toInt();
    accountLifetimeValue = json['account_lifetime_value']?.toString();
    qualifyingPeriodFrom = json['qualifying_period_from']?.toString();
    logData = json['log_data']?.toString();
    currentLevelExpiresAt = json['current_level_expires_at']?.toString();
    levelName = json['level_name']?.toString();
    levelImage = json['level_image']?.toString();
    cardImageUrl = json['card_image_url']?.toString();
    userName = json['user_name']?.toString();
    nextExpiringPoints = (json['next_expiring_points'] != null) ? DetailAccountDataNextExpiringPoints.fromJson(json['next_expiring_points']) : null;
    membershipCard = json['membership_card']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['program_id'] = programId;
    data['user_id'] = userId;
    data['membership_status'] = membershipStatus;
    data['current_level'] = currentLevel;
    data['previous_level'] = previousLevel;
    data['is_blacklisted'] = isBlacklisted;
    data['current_level_date'] = currentLevelDate;
    data['previous_level_date'] = previousLevelDate;
    data['membership_since'] = membershipSince;
    data['updated_at'] = updatedAt;
    data['available_point'] = availablePoint;
    data['total_gained_point'] = totalGainedPoint;
    data['used_point'] = usedPoint;
    data['pending_point'] = pendingPoint;
    data['expired_point'] = expiredPoint;
    data['account_lifetime_value'] = accountLifetimeValue;
    data['qualifying_period_from'] = qualifyingPeriodFrom;
    data['log_data'] = logData;
    data['current_level_expires_at'] = currentLevelExpiresAt;
    data['level_name'] = levelName;
    data['level_image'] = levelImage;
    data['card_image_url'] = cardImageUrl;
    data['user_name'] = userName;
    if (nextExpiringPoints != null) {
      data['next_expiring_points'] = nextExpiringPoints!.toJson();
    }
    data['membership_card'] = membershipCard;
    return data;
  }
}

class DetailAccount {
/*
{
  "status": "success",
  "message": "Success",
  "data": {
    "id": 365233,
    "member_id": "864095672",
    "program_id": "3e72fb2d-a2c6-4ec2-b6a7-0e19be9c2d80",
    "user_id": 436664,
    "membership_status": "ACTIVE",
    "current_level": 1,
    "previous_level": null,
    "is_blacklisted": false,
    "current_level_date": "2021-04-12T02:37:14.719Z",
    "previous_level_date": null,
    "membership_since": "2021-04-12T02:37:14.719Z",
    "updated_at": "2022-06-01T08:00:00.424Z",
    "available_point": 0,
    "total_gained_point": 7560,
    "used_point": 0,
    "pending_point": 0,
    "expired_point": 7560,
    "account_lifetime_value": null,
    "qualifying_period_from": "2021-04-12T02:37:18.765Z",
    "log_data": null,
    "current_level_expires_at": null,
    "level_name": "Hạng Chuẩn",
    "level_image": "https://test-statics.vntrip.vn/uploads/loyalty_program/20180710_483500_Standardlogo.png",
    "card_image_url": "https://test-statics.vntrip.vn/uploads/loyalty_program/20180710_418300_Standard.png",
    "user_name": "Bùi Chiên",
    "next_expiring_points": {},
    "membership_card": null
  }
}
*/

  String? status;
  String? message;
  DetailAccountData? data;

  DetailAccount({
    this.status,
    this.message,
    this.data,
  });
  DetailAccount.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? DetailAccountData.fromJson(json['data']) : null;
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
