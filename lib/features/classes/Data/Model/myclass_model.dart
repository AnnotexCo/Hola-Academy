class MyClassModel {
  final int id;
  final String name;
  final String description;
  final int maxCapacity;
  final String imagePath;
  final String coachName;
  final String programName;
  final double completion;

  MyClassModel({
    required this.id,
    required this.name,
    required this.description,
    required this.maxCapacity,
    required this.imagePath,
    required this.coachName,
    required this.programName,
    required this.completion,
  });

  factory MyClassModel.fromJson(Map<String, dynamic> json) {
    return MyClassModel(
      id: json['class']['id'],
      name: json['class']['name'],
      description: json['class']['description'],
      maxCapacity: json['class']['maxCapacity'],
      imagePath: json['class']['Image']['path'],
      coachName: json['class']['coach']['name'],
      programName: json['class']['program']['name'],
      completion: json['completion'].toDouble(),
    );
  }
}
