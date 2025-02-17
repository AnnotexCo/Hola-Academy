class UserModel {
  final String dob;
  final String email;
  final String gender;
  final num id;
  final String name;
  final String parentName;
  final String? parentWhatsappNumber;
  final num? profileImageId;
  final String role;
  final String phoneNumber;
  final String reachResource;
  final num balance;
  final String? salaryType;
  final num? salary;
  final String? address;
  final String? healthStatus;
  final String? nationality;
  final String? parentAddress;
  final String? parentNationality;
  final String qrCode;
  final String? lastSalaryDate;
  final Count count;
  final String userType;

  UserModel({
    required this.dob,
    required this.email,
    required this.gender,
    required this.id,
    required this.name,
    required this.parentName,
    this.parentWhatsappNumber,
    this.profileImageId,
    required this.role,
    required this.phoneNumber,
    required this.reachResource,
    required this.balance,
    this.salaryType,
    this.salary,
    this.address,
    this.healthStatus,
    this.nationality,
    this.parentAddress,
    this.parentNationality,
    required this.qrCode,
    this.lastSalaryDate,
    required this.count,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      role: json['role'],
      dob: json['dob'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      reachResource: json['reachResource'],
      balance: json['balance'],
      qrCode: json['qrCode'],
      parentName: json['parentName'],
      parentWhatsappNumber: json['parentWhatsappNumber'],
      profileImageId: json['profileImageId'],
      salaryType: json['salaryType'],
      salary: json['salary'],
      address: json['address'],
      healthStatus: json['healthStatus'],
      nationality: json['nationality'],
      parentNationality: json['parentNationality'],
      parentAddress: json['parentAddress'],
      lastSalaryDate: json['lastSalaryDate'],
      count: Count.fromJson(json['_count']),
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'id': id,
        'name': name,
        'role': role,
        'dob': dob,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'parentName': parentName,
        'parentWhatsappNumber': parentWhatsappNumber,
        'profileImageId': profileImageId,
        'reachResource': reachResource,
        'balance': balance,
        'salaryType': salaryType,
        'salary': salary,
        'address': address,
        'healthStatus': healthStatus,
        'nationality': nationality,
        'parentNationality': parentNationality,
        'parentAddress': parentAddress,
        'qrCode': qrCode,
        'lastSalaryDate': lastSalaryDate,
        '_count': count,
        'userType': userType,
      };
}

class Count {
  final num request;
  final num levelTrainee;
  Count({
    required this.request,
    required this.levelTrainee,
  });
  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      request: json['Request'],
      levelTrainee: json['LevelTrainee'],
    );
  }
  Map<String, dynamic> toMap() => {
        'Request': request,
        'LevelTrainee': levelTrainee,
      };
}
/*
{
  "message": "Request successful",
  "data": {
    "dob": "2001-01-01T00:00:00.000Z",
    "email": "coach@gmail.com",
    "gender": "MALE",
    "id": 3,
    "name": "coach name",
    "parentName": "coach parent name",
    "parentWhatsappNumber": null,
    "profileImageId": null,
    "role": "COACH",
    "phoneNumber": "+201234567890",
    "reachResource": "OTHER",
    "balance": 0,
    "salaryType": null,
    "salary": null,
    "address": null,
    "healthStatus": null,
    "nationality": null,
    "parentAddress": null,
    "parentNationality": null,
    "qrCode": "a1e20aa0-2f01-4311-ba3a-575cf740e7c8",
    "lastSalaryDate": null,
    "_count": {
      "Request": 0,
      "LevelTrainee": 0
    },
    "userType": "COACH"
  }
}
  */
