class UpdateUserModel {
  final String? dob;
  final String? gender;
  final String? name;
  final String? parentName;
  final String? parentWhatsappNumber;
  final String? phoneNumber;

  UpdateUserModel({
    this.dob,
    this.gender,
    this.name,
    this.parentName,
    this.parentWhatsappNumber,
    this.phoneNumber,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserModel(
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      parentName: json['parentName'],
      parentWhatsappNumber: json['parentWhatsappNumber'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'dob': dob,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'parentName': parentName,
        'parentWhatsappNumber': parentWhatsappNumber,
      };
}