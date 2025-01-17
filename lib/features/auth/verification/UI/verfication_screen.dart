import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';

import '../../../../core/components/custom_app_button.dart';
import '../../../../core/constants/color_manager.dart';
import 'widgets/build_back_arrow.dart';
import 'widgets/build_verfication_message.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());
  List<String> _codeList = [];

  @override
  void initState() {
    super.initState();
    // Initialize with empty strings
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height, // Ensure minimum height
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildBackArrow(context),
                    SizedBox(height: 48.h),
                    buildTextMessage(AppString.verification,
                        AppString.sentVerificationCode, '+20 *** **** ***'),
                    SizedBox(height: 48.h),
                    _customVerificationInputs(),
                    const Spacer(),
                    _buildTextButtons(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
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
                    _focusNodes[index + 1].requestFocus(); // Move to next input
                  } else {
                    _focusNodes[index].unfocus(); // Close keyboard on last box
                  }
                } else {
                  _codeList[index] = '';
                  if (index > 0) {
                    _focusNodes[index - 1]
                        .requestFocus(); // Move to previous input
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
            final code = _codeList.join();
            if (code.length == 6) {
              // TODO: verification logic here
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(),
                  ));
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
              onPressed: () {
                // Add resend logic here
              },
              child: Text(
                AppString.resend,
                style: TextStyle(
                  color: ColorManager.textRedColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
