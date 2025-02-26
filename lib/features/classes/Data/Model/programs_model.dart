import 'category_model.dart';

class ProgramsModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String allowedGender;
  final int minAge;
  final int maxAge;
  final String createdAt;
  final String updatedAt;
  final ImageModel? image;
  final CategoryModel? category;
  final List<LevelModel>? levels;
  final int? imageId; // If you still need the imageId separately

  ProgramsModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.allowedGender,
    required this.minAge,
    required this.maxAge,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.category,
    this.levels,
    this.imageId,
  });

  factory ProgramsModel.fromJson(Map<String, dynamic> json) {
    return ProgramsModel(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      allowedGender: json['allowedGender'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: json['Image'] != null ? ImageModel.fromJson(json['Image']) : null,
      category:
          json['Category'] != null ? CategoryModel.fromJson(json['Category']) : null,
      levels: json['Level'] != null
          ? List<LevelModel>.from(
              (json['Level'] as List).map((x) => LevelModel.fromJson(x)))
          : null,
      imageId: json['imageId'], // Optional if still needed
    );
  }
}

class ImageModel {
  final int id;
  final String name;
  final String path;
  final String type;
  final int size;

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




class LevelModel {
  final int id;
  final int order;
  final String name;
  final String description;
  final String clarification;
  final int programId;
  final int imageId;
  final int lessonNumber;
  final int price;

  LevelModel({
    required this.id,
    required this.order,
    required this.name,
    required this.description,
    required this.clarification,
    required this.programId,
    required this.imageId,
    required this.lessonNumber,
    required this.price,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      order: json['order'],
      name: json['name'],
      description: json['description'],
      clarification: json['clarification'] ?? "", // Handle null safely
      programId: json['programId'],
      imageId: json['imageId'],
      lessonNumber: json['lessonNumber'],
      price: json['price'],
    );
  }
}