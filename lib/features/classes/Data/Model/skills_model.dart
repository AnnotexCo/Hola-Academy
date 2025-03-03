
class ApiResponse {
  final String message;
  final TrainingSession data;

  ApiResponse({required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      data: TrainingSession.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data.toJson(),
      };
}

class TrainingSession {
  final int id;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int traineeId;
  final int classId;
  final bool isAttended;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TrainingClass trainingClass;

  TrainingSession({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.traineeId,
    required this.classId,
    required this.isAttended,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.trainingClass,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      traineeId: json['traineeId'],
      classId: json['classId'],
      isAttended: json['isAttended'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      trainingClass: TrainingClass.fromJson(json['class']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
        'traineeId': traineeId,
        'classId': classId,
        'isAttended': isAttended,
        'isDeleted': isDeleted,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'class': trainingClass.toJson(),
      };
}

class TrainingClass {
  final int id;
  final String name;
  final String description;
  final int maxCapacity;
  final int imageId;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int levelId;
  final int coachId;
  final int programId;
  final int categoryId;
  final TrainingLevel level;

  TrainingClass({
    required this.id,
    required this.name,
    required this.description,
    required this.maxCapacity,
    required this.imageId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.levelId,
    required this.coachId,
    required this.programId,
    required this.categoryId,
    required this.level,
  });

  factory TrainingClass.fromJson(Map<String, dynamic> json) {
    return TrainingClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      maxCapacity: json['maxCapacity'],
      imageId: json['imageId'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      levelId: json['levelId'],
      coachId: json['coachId'],
      programId: json['programId'],
      categoryId: json['categoryId'],
      level: TrainingLevel.fromJson(json['level']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'maxCapacity': maxCapacity,
        'imageId': imageId,
        'isDeleted': isDeleted,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'levelId': levelId,
        'coachId': coachId,
        'programId': programId,
        'categoryId': categoryId,
        'level': level.toJson(),
      };
}

class TrainingLevel {
  final int id;
  final int order;
  final String name;
  final String description;
  final String clarification;
  final int programId;
  final int imageId;
  final int lessonNumber;
  final double price;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Skill> skills;

  TrainingLevel({
    required this.id,
    required this.order,
    required this.name,
    required this.description,
    required this.clarification,
    required this.programId,
    required this.imageId,
    required this.lessonNumber,
    required this.price,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.skills,
  });

  factory TrainingLevel.fromJson(Map<String, dynamic> json) {
    return TrainingLevel(
      id: json['id'],
      order: json['order'],
      name: json['name'],
      description: json['description'],
      clarification: json['clarification'],
      programId: json['programId'],
      imageId: json['imageId'],
      lessonNumber: json['lessonNumber'],
      price: (json['price'] as num).toDouble(),
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      skills: (json['Skill'] as List<dynamic>)
          .map((skill) => Skill.fromJson(skill))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order': order,
        'name': name,
        'description': description,
        'clarification': clarification,
        'programId': programId,
        'imageId': imageId,
        'lessonNumber': lessonNumber,
        'price': price,
        'isDeleted': isDeleted,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'Skill': skills.map((skill) => skill.toJson()).toList(),
      };
}

class Skill {
  final int id;
  final String name;
  final String description;
  final int levelId;
  final bool isDeleted;
  final int? imageId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.levelId,
    required this.isDeleted,
    this.imageId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      levelId: json['levelId'],
      isDeleted: json['isDeleted'],
      imageId: json['imageId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'levelId': levelId,
        'isDeleted': isDeleted,
        'imageId': imageId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
