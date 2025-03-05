class SignUpModel {
  final String name;
  final String? parentName;
  final String email;
  final String? dob;
  final String? gender;
  final String phoneNumber;
  final String? parentWhatsappNumber;
  final String password;

  SignUpModel({
    required this.name,
    this.parentName,
    required this.email,
    this.dob,
    this.gender,
    required this.phoneNumber,
    this.parentWhatsappNumber,
    required this.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'],
      parentName: json['parentName'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      parentWhatsappNumber: json['parentWhatsappNumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'parentName': parentName,
        'email': email,
        'dob': dob,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'parentWhatsappNumber': parentWhatsappNumber,
        'password': password,
      };
}
