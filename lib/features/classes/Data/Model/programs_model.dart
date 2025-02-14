class ProgramsModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final int imageId;
  final String allowedGender;
  final int minAge;
  final int maxAge;
  final String createdAt;
  final String updatedAt;
  final ImageModel image;
  final CategoryModel category;
  final List<LevelModel>? levels;

  ProgramsModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.imageId,
    required this.allowedGender,
    required this.minAge,
    required this.maxAge,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.category,
    this.levels,
  });

  factory ProgramsModel.fromJson(Map<String, dynamic> json) {
    return ProgramsModel(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      imageId: json['imageId'],
      allowedGender: json['allowedGender'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: ImageModel.fromJson(json['Image']),
      category: CategoryModel.fromJson(json['Category']),
      levels: json['Level'] != null
          ? List<LevelModel>.from(
              json['Level'].map((x) => LevelModel.fromJson(x)))
          : [],
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

class CategoryModel {
  final int id;
  final String name;
  final int imageId;
  final String description;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageId,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageId: json['imageId'],
      description: json['description'],
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
      clarification: json['clarification'],
      programId: json['programId'],
      imageId: json['imageId'],
      lessonNumber: json['lessonNumber'],
      price: json['price'],
    );
  }
}
