import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class TransactionTapBar extends StatelessWidget {
  final TabController tabController;
  final void Function(int)? onTap;
  const TransactionTapBar({super.key, required this.tabController, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378.84.w,
      //height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: ColorManager.linearGradient1,
      ),
      child: Column(
        children: [
          TabBar(
            overlayColor: WidgetStateProperty.all(Colors.grey.shade300),
            automaticIndicatorColorAdjustment: false,
            dividerColor: Colors.transparent,
            splashBorderRadius: BorderRadius.circular(26.r),
            unselectedLabelColor: ColorManager.primaryOrangeColor,
            controller: tabController,
            onTap: onTap,
            tabs: const [
              Tab(text: AppString.moneyIn),
              Tab(text: AppString.moneyOut),
            ],
            labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.whiteColor),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            indicator: BoxDecoration(
              /*boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.inner,
                  color: Colors.black.withValues(alpha: 0.1), // Shadow color
                  spreadRadius: 0, // How wide the shadow spreads
                  blurRadius: 4, // How soft the shadow is
                  offset: Offset(0, 4), // The shadow's offset
                ),
              ],*/
              borderRadius: BorderRadius.circular(50.r),
              color: ColorManager.primaryOrangeColor,
            ),
            indicatorPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ],
      ),
    );
  }
}
