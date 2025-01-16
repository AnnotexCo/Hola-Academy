import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class CustomProfileBackgroung extends StatelessWidget {
  const CustomProfileBackgroung({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ImageManager.profileFrame),
        Column(
          children: [
            Stack(
              children: [
                // Profile image inside a circular border
                Container(
                  height: 150.h,
                  width: 150.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.linearGradient1,
                          ColorManager.linearGradient2,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: Container(
                      height: 140.h,
                      width: 140.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                          'https://s3-alpha-sig.figma.com/img/e915/f882/38ac6007aa5be950081f8f386a727a10?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=q7Gqf~xP2DuXMzmxmyIllwcM4Bi2JqGk~M78tq5nYVmVHgqta1RtLLVgxx~UkJgYfaiZpk090R7glwe6Y9DP3CO0ItgZW~RrpJqcmzMoalU9YR8hfUm~azHvjtc1xfCaaExOQnP6UV1aOPvx8QizON25RBlvYizobt3jTiqVmKcL0pwIcaSFAh1qQ6fe5GayPDxfW9Ds~8fiyqxVzK0l6zl~nKa9L-otRwWfs5NL~6R3kHhmmwuH2P9Vjji8yo192lzPi-TRxkIY9JRzX1zCMPK57N4cRGMvMO4tnW0gZxlDjAWuDzzpsYVtw5efQLCbQ-hQMM31vAXcr1g-RI8Tlg__'), // Replace with your image URL
                    ),
                  ),
                ),
                // Edit icon
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: ColorManager.backgroundPinkColor,
                    child: Icon(
                      Icons.edit,
                      color: ColorManager.textRedColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Jennifer James',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}