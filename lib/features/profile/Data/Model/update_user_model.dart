import 'dart:io';

class UpdateUserModel {
  final String? name;
  final String? parentName;
  final File? picture;

  UpdateUserModel({
    this.name,
    this.parentName,
    this.picture,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserModel(
      name: json['name'],
      parentName: json['parentName'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'parentName': parentName,
        'picture': picture,
      };
}