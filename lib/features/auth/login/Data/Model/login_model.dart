class LoginModel{
  final String? email;
  final String? phoneNumber;
  final String password;

  LoginModel({
    this.email,
    this.phoneNumber,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }

Map<String, dynamic> toMap() => {
  'email': email,
  'phoneNumber': phoneNumber,
  'password': password,
};

}