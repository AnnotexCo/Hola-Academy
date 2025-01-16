import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class TapBar extends StatefulWidget {
  const TapBar({super.key});

  @override
  State<TapBar> createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: ColorManager.primaryOrangeColor,
      ),
      child: TabBar(
        overlayColor: WidgetStateProperty.all(Colors.grey.shade300),
        automaticIndicatorColorAdjustment: false,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(24.r),
        unselectedLabelColor: ColorManager.backgroundColor,
        controller: _tabController,
        tabs: const [
          Tab(text: "Educational"),
          Tab(text: "Training"),
        ],
        labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.primaryOrangeColor),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        indicator: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.inner,
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 0, // How wide the shadow spreads
              blurRadius: 4, // How soft the shadow is
              offset: Offset(0, 4), // The shadow's offset
            ),
          ],
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.white,
        ),
        indicatorPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }
}
