import 'dart:convert';

// Enum for notification types
// ignore: constant_identifier_names
enum NotificationType { CLASS, CATEGORY, LEVEL, PROGRAM, PRIVATE, UNKNOWN }

class NotificationModel {
  final String message;
  final List<NotificationData> data;

  NotificationModel({
    required this.message,
    required this.data,
  });

  // Factory constructor to parse JSON
  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>?)
              ?.map((item) => NotificationData.fromMap(item))
              .toList() ??
          [],
    );
  }

  // Filter notifications by read status
  List<NotificationData> filterByReadStatus(String status) {
    return data.where((notification) => notification.status == status).toList();
  }
}

class NotificationData {
  final int id;
  final String title;
  final String message;
  final int receiverId;
  final NotificationType type;
  final int? senderId;
  final int? classId;
  final int? programId;
  final int? levelId;
  final int? categoryId;
  final String status; // READ or UNREAD
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  NotificationData({
    required this.id,
    required this.title,
    required this.message,
    required this.receiverId,
    required this.type,
    this.senderId,
    this.classId,
    this.programId,
    this.levelId,
    this.categoryId,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse JSON
  factory NotificationData.fromMap(Map<String, dynamic> json) {
    return NotificationData(
      id: json["id"],
      title: json["title"],
      message: json["message"],
      receiverId: json["receiverId"],
      type: _mapType(json["type"]),
      senderId: json["senderId"],
      classId: json["classId"],
      programId: json["programId"],
      levelId: json["levelId"],
      categoryId: json["categoryId"],
      status: json["status"],
      isDeleted: json["isDeleted"] ?? false,
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  // Convert string type to enum
  static NotificationType _mapType(String? type) {
    switch (type?.toUpperCase()) {
      case "CLASS":
        return NotificationType.CLASS;
      case "CATEGORY":
        return NotificationType.CATEGORY;
      case "LEVEL":
        return NotificationType.LEVEL;
      case "PROGRAM":
        return NotificationType.PROGRAM;
      case "PRIVATE":
        return NotificationType.PRIVATE;
      default:
        return NotificationType.UNKNOWN;
    }
  }
}
