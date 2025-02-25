import 'dart:io';

import 'package:dio/dio.dart';

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
      picture:null,
    );
  }

  Future<FormData> toFormData() async {
    Map<String, dynamic> data = {
      'name': name,
      'parentName': parentName,
    };

    if (picture != null) {
      data['picture'] = await MultipartFile.fromFile(
        picture!.path,
        filename: picture!.path.split('/').last,
      );
    }

    return FormData.fromMap(data);
  }
}