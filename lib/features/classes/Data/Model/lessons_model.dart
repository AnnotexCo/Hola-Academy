class LessonModel {
  final int id;
  final DateTime date;
  final String startTime;
  final String endTime;
  int? lessonEvaluationCount;
  final int classId;
  final bool isAttended;
  final int traineeId;
  final dynamic classDetails;
  List<dynamic>? lessonEvaluations;

  LessonModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.lessonEvaluationCount,
    required this.classId,
    required this.isAttended,
    required this.traineeId,
    required this.classDetails,
    this.lessonEvaluations,
  });

  factory LessonModel.fromMap(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] != null ? json['id'] as int : 0,
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      lessonEvaluationCount:
          json['_count'] != null && json['_count']['LessonEvaluation'] != null
              ? json['_count']['LessonEvaluation'] as int
              : 0,
      classId: json['classId'] != null ? json['classId'] as int : 0,
      isAttended: json['isAttended'],
      traineeId: json['traineeId'],
      classDetails: ClassDetails.fromJson(json['class']),
      lessonEvaluations: json['LessonEvaluation'] != null
          ? List<dynamic>.from(json['LessonEvaluation'])
          : [], // Default to empty list if no evaluations are present
    );
  }

  factory LessonModel.fromMapV2(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] != null ? json['id'] as int : 0,
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      lessonEvaluationCount:
          json['_count'] != null && json['_count']['LessonEvaluation'] != null
              ? json['_count']['LessonEvaluation'] as int
              : 0,
      classId: json['classId'] != null ? json['classId'] as int : 0,
      isAttended: json['isAttended'],
      traineeId: json['traineeId'],
      classDetails: CLassDetailsNextLesson.fromJson(json['class']),
      lessonEvaluations: json['LessonEvaluation'] != null
          ? List<dynamic>.from(json['LessonEvaluation'])
          : [], // Default to empty list if no evaluations are present
    );
  }
}

class ClassDetails {
  final int id;
  final String name;
  final int coachId;
  final int skillCount;

  ClassDetails({
    required this.id,
    required this.name,
    required this.coachId,
    required this.skillCount,
  });

  factory ClassDetails.fromJson(Map<String, dynamic> json) {
    return ClassDetails(
      id: json['id'],
      name: json['name'],
      coachId: json['coachId'],
      skillCount: json['level']['_count']['Skill'],
    );
  }
}

class CLassDetailsNextLesson {
  final String name;
  final String createdAt;

  CLassDetailsNextLesson({
    required this.name,
    required this.createdAt,
  });

  factory CLassDetailsNextLesson.fromJson(Map<String, dynamic> json) {
    return CLassDetailsNextLesson(
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}
