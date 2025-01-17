import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/UI/widgets/booked_cared.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppString.booked,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of booked courses
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 34.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: BookedCard(
                    imageUrl: ImageManager
                        .programImage, // Replace with your image URL
                    title: "Private",
                    minAge: "3",
                    maxAge: "60",
                    suitableFor: "All Gender, Baby (0-2)",
                    status: "Booked",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
