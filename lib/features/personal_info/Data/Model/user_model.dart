class UserModel{
  final String email;
  final num id;
  final String? name;
  final String role;
  final String? dob;
  final String? gender;
  final String phoneNumber;

  UserModel({
    required this.email,
    required this.id,
    this.name,
    required this.role,
    this.dob,
    this.gender,
    required this.phoneNumber,
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
    );
  }

Map<String, dynamic> toMap() => {
  'email': email,
  'id': id,
  'name': name,
  'role': role,
  'dob': dob,
  'gender' : gender,
  'phoneNumber': phoneNumber,
};

}
/*
{
  "message": "Request successful",
  "data": {
    "email": "mayar.alaa252@gmail.com",
    "id": 16,
    "name": "Mayar",
    "role": "TRAINEE",
    "gender": "FEMALE",
    "dob": "2000-01-01T00:00:00.000Z",
    "phoneNumber": "+201012345555"
  }
}
  */