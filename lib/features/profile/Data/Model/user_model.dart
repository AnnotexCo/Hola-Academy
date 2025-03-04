class UserModel {
  final String? dob;
  final String? email;
  final String? gender;
  final num? id;
  final String? name;
  final String? parentName;
  final String? parentWhatsappNumber;
  final ImageModel? profileImage;
  final String? role;
  final String? phoneNumber;
  final String? reachResource;
  final num? balance;
  final String? salaryType;
  final num? salary;
  final String? address;
  final String? healthStatus;
  final String? nationality;
  final String? parentAddress;
  final String? parentNationality;
  final String? qrCode;
  final String? lastSalaryDate;
  final Count? count;
  final String? userType;

  UserModel({
    this.dob,
    this.email,
    this.gender,
    this.id,
    this.name,
    this.parentName,
    this.parentWhatsappNumber,
    this.profileImage,
    this.role,
    this.phoneNumber,
    this.reachResource,
    this.balance,
    this.salaryType,
    this.salary,
    this.address,
    this.healthStatus,
    this.nationality,
    this.parentAddress,
    this.parentNationality,
    this.qrCode,
    this.lastSalaryDate,
    this.count,
    this.userType,
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
      profileImage: json['ProfileImage'] != null
          ? ImageModel.fromJson(json['ProfileImage'])
          : null,
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

class ImageModel {
  final int? id;
  final String? name;
  final String? path;
  final String? type;
  final int? size;

  ImageModel({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      type: json['type'],
      size: json['size'],
    );
  }
}
