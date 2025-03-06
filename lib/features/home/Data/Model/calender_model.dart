class CalenderModel {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final int classId;
  final bool isAttended;
  final int traineeId;
  CalenderModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.classId,
    required this.isAttended,
    required this.traineeId,
  });
  factory CalenderModel.fromMap(Map<String, dynamic> map) {
    return CalenderModel(
      id: map['id'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      classId: map['classId'],
      isAttended: map['isAttended'],
      traineeId: map['traineeId'],
    );
  }
}
