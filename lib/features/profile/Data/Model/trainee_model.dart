class AllUsersModel {
  final String message;
  final int totalDocs;
  final Data data;
  AllUsersModel({
    required this.message,
    required this.totalDocs,
    required this.data,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) => AllUsersModel(
        message: json['message'],
        totalDocs: json['totalDocs'],
        data: Data.fromJson(json['data']),
      );
}

class Data {
  final int totalDocs;
  final int count;
  final List<User> users;
  Data({
    required this.totalDocs,
    required this.count,
    required this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalDocs: json['totalDocs'],
        count: json['count'],
        users: List.from(json['users']).map((e) => User.fromJson(e)).toList(),
      );
}

class User {
  final int? id;
  final String? email;
  final String? name;
  final String? gender;
  final String? dob;
  final String? parentName;
  final String? phoneNumber;
  final String? parentWhatsappNumber;
  final String? role;
  final ProfileImage? profileImage;
  User({
    this.id,
    this.email,
    this.name,
    this.gender,
    this.dob,
    this.parentName,
    this.phoneNumber,
    this.parentWhatsappNumber,
    this.role,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'],
      parentName: json['parentName'],
      phoneNumber: json['phoneNumber'],
      parentWhatsappNumber: json['parentWhatsappNumber'],
      role: json['role'],
      profileImage:
          json['ProfileImage'] != null ? ProfileImage.fromJson(json['ProfileImage']) : null);
}

class ProfileImage {
  final int? id;
  final String? name;
  final String? path;
  final String? type;
  final int? size;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  ProfileImage({
    this.id,
    this.name,
    this.path,
    this.type,
    this.size,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json['id'],
        name: json['name'],
        path: json['path'] ?? "programs/image-1740165531232-997805655.png",
        type: json['type'],
        size: json['size'],
        isDeleted: json['isDeleted'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
