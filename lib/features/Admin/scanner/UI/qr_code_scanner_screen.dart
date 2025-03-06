import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/Admin/scanner/Logic/attendance_cubit.dart';
import 'package:hola_academy/features/Admin/scanner/Logic/attendance_state.dart';
import 'package:hola_academy/features/Admin/scanner/UI/scan_complete.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_button.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AttendanceSuccess) {
            return Column(
              children: [
                ScanComplete(),
                SizedBox(height: 100.h),
                CustomButton(
                    onTap: () {
                      context.read<AttendanceCubit>().resetState();
                    },
                    height: 72.h,
                    text: AppString.continueButton)
              ],
            );
          }
          if (state is AttendanceFailure) {
            return Column(
              children: [
                NotFoundScreen(title: AppString.failToScan),
                SizedBox(height: 18.h),
                Text(
                  state.error,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.grayColorHeadline,
                  ),
                ),
                SizedBox(height: 100.h),
                CustomButton(
                    onTap: () {
                      context.read<AttendanceCubit>().resetState();
                    },
                    height: 72.h,
                    text: AppString.tryAgain)
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.orange,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 250,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
  ) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code; // Access scanned data here
        // Optionally, navigate to another page or perform an action
        if (scannedData != null) {
          context.read<AttendanceCubit>().markAttendance(qrCode: scannedData!);
          controller.pauseCamera();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
