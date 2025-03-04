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
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      levelId: json['levelId'] as int,
      isDeleted: json['isDeleted'] as bool,
      imageId: json['imageId'] != null ? json['imageId'] as int : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<Skill> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Skill.fromJson(json)).toList();
  }
}
