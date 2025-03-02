class LessonModel {
  final int id;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int lessonEvaluationCount;
  final int classId;
  final bool isAttended;
  final int traineeId;
  final ClassDetails classDetails;
  final List<dynamic> lessonEvaluations;

  LessonModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.lessonEvaluationCount,
    required this.classId,
    required this.isAttended,
    required this.traineeId,
    required this.classDetails,
    required this.lessonEvaluations,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      lessonEvaluationCount: json['_count']['LessonEvaluation'],
      classId: json['classId'],
      isAttended: json['isAttended'],
      traineeId: json['traineeId'],
      classDetails: ClassDetails.fromJson(json['class']),
      lessonEvaluations: List<dynamic>.from(json['LessonEvaluation']),
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
