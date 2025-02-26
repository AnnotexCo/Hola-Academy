class CategoryModel {
  final int id;
  final String name;
  final String description;
  final bool isDeleted;
  final int parentCategoryId;
  final String createdAt;
  final String updatedAt;
  final ImageModel? image; // Nullable to prevent crashes

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isDeleted,
    required this.parentCategoryId,
    required this.createdAt,
    required this.updatedAt,
    this.image, // Nullable
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isDeleted: json['isDeleted'],
      parentCategoryId: json['parentCategoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: json['Image'] != null ? ImageModel.fromJson(json['Image']) : null,
    );
  }
}


class ImageModel {
  final int id;
  final String name;
  final String path;
  final String type;
  final int? size; // Nullable size
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  ImageModel({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    this.size, // Nullable
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      type: json['type'],
      size: json['size'], // Nullable
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

