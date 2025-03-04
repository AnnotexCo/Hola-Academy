import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState{}

class AttendanceLoading extends AttendanceState{}

class AttendanceSuccess extends AttendanceState{
  final String message;
  AttendanceSuccess({required this.message});
}

class AttendanceFailure extends AttendanceState{
  final String error;
  AttendanceFailure({required this.error});
}
