import 'package:hola_academy/core/networking/Dio/Attendance/dio_attendance_api.dart';

class AttendanceRepo {
  final DioAttendance dioAttendance;

  AttendanceRepo({required this.dioAttendance});

  Future<dynamic> markAttendance({required String qrCode}) async {
    return await dioAttendance.markAttendance(qrCode: qrCode);
  }
}
