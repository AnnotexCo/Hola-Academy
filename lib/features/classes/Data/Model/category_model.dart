class CategoryModel {
  late num id;
  late String name;
  late num imageId;
  late String description;
  late bool isDeleted;
  late num parentCategoryId;
  late String createdAt;
  late String updatedAt;
  late Image image;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageId,
    required this.description,
    required this.isDeleted,
    required this.parentCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageId: json['imageId'],
      description: json['description'],
      isDeleted: json['isDeleted'],
      parentCategoryId: json['parentCategoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: Image.fromJson(json['Image']),
    );
  }
}

class Image {
  late num id;
  late String name;
  late String path;
  late String type;
  late num size;
  late bool isDeleted;
  late String createdAt;
  late String updatedAt;

  Image({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      type: json['type'],
      size: json['size'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
