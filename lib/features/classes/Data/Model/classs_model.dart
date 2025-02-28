class ClasssModel {
  final int id;
  final String name;
  final String description;
  final int maxCapacity;
  final int programId;
  final int coachId;
  final int categoryId;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'maxCapacity': maxCapacity,
      'programId': programId,
      'coachId': coachId,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
    };
  }

  factory ClasssModel.fromMap(Map<String, dynamic> map) {
    return ClasssModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      maxCapacity: map['maxCapacity'] as int,
      programId: map['programId'] as int,
      coachId: map['coachId'] as int,
      categoryId: map['categoryId'] as int,
      imageUrl: map['Image']['path'] as String,
    );
  }

  ClasssModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.maxCapacity,
      required this.programId,
      required this.coachId,
      required this.categoryId,
      required this.imageUrl});
}
