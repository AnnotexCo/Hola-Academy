class BannerModel {
  final int id;
  final int imageId;
  final String title;
  // final String? description;
  final bool isAdv;
  final String url;
  // final String date;
  final String createdAt;
  final String updatedAt;
  final ImageBannerModel image;

  BannerModel({
    required this.id,
    required this.imageId,
    required this.title,
    // this.description,
    required this.isAdv,
    required this.url,
    // required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageId: json['imageId'],
      title: json['title'],
      // description: json['description'],
      isAdv: json['isAdv'], 
      url: json['url'],
      // date: json['date'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: ImageBannerModel.fromJson(json['Image']),
    );
  }
}

class ImageBannerModel {
  final int id;
  final String name;
  final String path;
  final String type;
  final int size;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  ImageBannerModel({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageBannerModel.fromJson(Map<String, dynamic> json) {
    return ImageBannerModel(
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
