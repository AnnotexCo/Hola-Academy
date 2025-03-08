import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/features/auth/verification/Data/Model/reset_args.dart';
import 'package:hola_academy/features/auth/verification/Logic/cubit/check_otp_cubit.dart';

import '../../../../core/components/custom_app_button.dart';
import '../../../../core/constants/color_manager.dart';
import '../../forgot_password/Logic/cubit/forget_password_cubit.dart';
import 'widgets/build_back_arrow.dart';
import 'widgets/build_verfication_message.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());
  List<String> _codeList = [];
  String code = '';
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _codeList = List.filled(6, '');
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _textControllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCooldown() {
    setState(() {
      _remainingSeconds = 30;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<CheckOtpCubit, CheckOtpState>(
            listener: (context, state) {
              if (state is CheckOtpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Thank you For Verification")),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.resetPassword,
                  (route) => false,
                  arguments: ResetPasswordArgs(email: widget.email, otp: code),
                );
              } else if (state is CheckOtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildBackArrow(context),
                    SizedBox(height: 48.h),
                    buildTextMessage(AppString.verification,
                        AppString.sentVerificationCode, widget.email),
                    SizedBox(height: 48.h),
                    _customVerificationInputs(),
                    SizedBox(height: 80.h),
                    _buildTextButtons(),
                    SizedBox(height: 32.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _customVerificationInputs() {
    return Container(
      width: 384.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: ColorManager.backgroundPinkColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorManager.textRedColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 40.w,
            child: TextField(
              controller: _textControllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                counterText: "",
                hintText: "X",
                hintStyle: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.textRedColor,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.textRedColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.textRedColor,
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.textRedColor,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _codeList[index] = value;
                  if (index < 5) {
                    _focusNodes[index + 1].requestFocus();
                  } else {
                    _focusNodes[index].unfocus();
                  }
                } else {
                  _codeList[index] = '';
                  if (index > 0) {
                    _focusNodes[index - 1].requestFocus();
                  }
                }
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextButtons() {
    return Column(
      children: [
        CustomAppButton(
          text: AppString.send,
          icon: Icons.send,
          onPressed: () {
            code = _codeList.join();
            if (code.length == 6) {
              context.read<CheckOtpCubit>().verifyOtp(widget.email, code);
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.didNotReceiveCode,
              style: TextStyle(
                color: ColorManager.textRedColor.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            TextButton(
              onPressed: _remainingSeconds == 0
                  ? () {
                      context
                          .read<ForgetPasswordCubit>()
                          .forgetpassword(widget.email);
                      _startResendCooldown();
                    }
                  : null,
              child: Text(
                _remainingSeconds == 0
                    ? AppString.resend
                    : "Resend in $_remainingSeconds s",
                style: TextStyle(
                  color: ColorManager.textRedColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  decoration: _remainingSeconds == 0
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
