import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/Admin/scanner/Data/Repo/attendance_repo.dart';
import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState>{
  final AttendanceRepo attendanceRepo;

  AttendanceCubit(this.attendanceRepo) : super(AttendanceInitial());

  Future<void> markAttendance({required String qrCode}) async {
    try {
      if (!isClosed) emit(AttendanceLoading());
      final response = await attendanceRepo.markAttendance(qrCode: qrCode);
      if (!isClosed) emit(AttendanceSuccess(message: response['message']));
    } catch (error) {
      if (!isClosed) emit(AttendanceFailure(error: error.toString()));
    }
  }

  void resetState() => emit(AttendanceInitial());

}
