class Evaluation {
  final int id;
  final String name;
  final String description;
  final List<LessonEvaluation> lessonEvaluations;

  Evaluation({
    required this.id,
    required this.name,
    required this.description,
    required this.lessonEvaluations,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      lessonEvaluations: (json['LessonEvaluation'] as List)
          .map((e) => LessonEvaluation.fromJson(e))
          .toList(),
    );
  }

  static List<Evaluation> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Evaluation.fromJson(json)).toList();
  }
}

class LessonEvaluation {
  final bool passed;
  final int score;
  final Lesson lesson;

  LessonEvaluation({
    required this.passed,
    required this.score,
    required this.lesson,
  });

  factory LessonEvaluation.fromJson(Map<String, dynamic> json) {
    return LessonEvaluation(
      passed: json['passed'],
      score: json['score'],
      lesson: Lesson.fromJson(json['Lesson']),
    );
  }
}

class Lesson {
  final String date;

  Lesson({required this.date});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(date: json['date']);
  }
}
