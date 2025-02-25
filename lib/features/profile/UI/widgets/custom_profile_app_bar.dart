import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/Routing/app_router.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/local_db/save_token.dart';

class CustomProfileAppBar extends StatefulWidget {
  final bool qrCode;
  const CustomProfileAppBar({super.key, this.qrCode = false});

  @override
  State<CustomProfileAppBar> createState() => _CustomProfileAppBarState();
}

class _CustomProfileAppBarState extends State<CustomProfileAppBar> {
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    String? role = await SaveTokenDB.getRole();
    setState(() {
      _userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 31.w,
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, Routes.layoutScreen);
                // Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.textRedColor,
              ),
            ),
            Row(
              children: [
                // if (widget.qrCode == true)
                if (_userRole == AppString.trainee ||
                    _userRole == AppString.coach)
                  BlocBuilder<UserDataCubit, UserDataState>(
                    builder: (context, state) {
                      String qr = " ";
                      if (state is UserDataSuccess) {
                        qr = state.userModel.qrCode;
                      }
                      return GestureDetector(
                          onTap: () async {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 131.h),
                                  child: Container(
                                      height: 702.h,
                                      width: 439.w,
                                      //padding: EdgeInsets.symmetric(vertical: 131.h),
                                      decoration: BoxDecoration(
                                        color: ColorManager.whiteColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25.r),
                                        ),
                                      ),
                                      child: Center(
                                          child: QrImageView(
                                        data: qr,
                                        size: 300,
                                        version: QrVersions.auto,
                                      ))),
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset(ImageManager.scanQr));
                    },
                  ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.logoutScreen);
                    logout();
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageManager.logOut),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            ColorManager.linearGradient1,
                            ColorManager.linearGradient2,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: Text(
                          AppString.logOut,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Besley',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}

Future<void> logout() async {
  await SaveTokenDB.deleteTokenAndRole(); // Clear both token & role
}
