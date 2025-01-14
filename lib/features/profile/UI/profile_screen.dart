import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Row(children: [
          Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.textRedColor,
          ),
          Row(
            children: [
              SvgPicture.asset(ImageManager.logOut),
              ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            //AppString.Log out
            'Gradient Text',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Important: set a base color
            ),
          ),),
            ],
          ),
        ]),
      ])),
    );
  }
}
