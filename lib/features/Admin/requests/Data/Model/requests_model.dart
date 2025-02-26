import '../../../../classes/Data/Model/programs_model.dart';

class RequestsModel {
  final int id;
  final int userId;
  final int programId;
  final String note;
  final String status;
  final String createdAt;
  final String updatedAt;
  final FileModel? file;
  final RequestUserModel? user;
  final ProgramsModel? program;

  RequestsModel({
    required this.id,
    required this.userId,
    required this.programId,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.file,
    this.user,
    this.program,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      id: json['id'],
      userId: json['userId'],
      programId: json['programId'],
      note: json['note'] ?? "",
      status: json['status'] ?? "UNKNOWN",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      file: json['File'] != null ? FileModel.fromJson(json['File']) : null,
      user: json['User'] != null ? RequestUserModel.fromJson(json['User']) : null,
      program: json['Program'] != null ? ProgramsModel.fromJson(json['Program']) : null,
    );
  }
}

class FileModel {
  final int id;
  final String name;
  final String? path;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileModel({
    required this.id,
    required this.name,
    this.path,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}


class ProfileImageModel {
  final int id;
  final String path;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileImageModel({
    required this.id,
    required this.path,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      id: json['id'],
      path: json['path'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
class RequestUserModel {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String dob;
  final String phoneNumber;
  final String parentName;
  final String parentWhatsappNumber;
  final String address;
  final String healthStatus;
  final String nationality;
  final String parentAddress;
  final String parentNationality;
  final String qrCode;
  final String role;
  final int balance;
  final String reachResource;
  final ProfileImageModel? profileImage;

  RequestUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
    required this.parentName,
    required this.parentWhatsappNumber,
    required this.address,
    required this.healthStatus,
    required this.nationality,
    required this.parentAddress,
    required this.parentNationality,
    required this.qrCode,
    required this.role,
    required this.balance,
    required this.reachResource,
    this.profileImage,
  });

  factory RequestUserModel.fromJson(Map<String, dynamic> json) {
    return RequestUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      parentName: json['parentName'],
      parentWhatsappNumber: json['parentWhatsappNumber'],
      address: json['address'],
      healthStatus: json['healthStatus'],
      nationality: json['nationality'],
      parentAddress: json['parentAddress'],
      parentNationality: json['parentNationality'],
      qrCode: json['qrCode'],
      role: json['role'],
      balance: json['balance'],
      reachResource: json['reachResource'],
      profileImage: json['ProfileImage'] != null ? ProfileImageModel.fromJson(json['ProfileImage']) : null,
    );
  }
}
