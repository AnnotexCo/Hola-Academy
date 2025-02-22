class RequestsModel {
  final int id;
  final int userId;
  final int programId;
  final String note;
  final int imageId;
  final String status;
  final String createdAt;
  final String updatedAt;
  final FileModel file;

  RequestsModel({
    required this.id,
    required this.userId,
    required this.programId,
    required this.note,
    required this.imageId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.file,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      id: json['id'],
      userId: json['userId'],
      programId: json['programId'],
      note: json['note'],
      imageId: json['imageId'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt:json['updatedAt'],
      file: FileModel.fromJson(json['File']),
    );
  }
}

class FileModel {
  final int id;
  final String name;
  final String path;
  final String type;
  final int size;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileModel({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      type: json['type'],
      size: json['size'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
