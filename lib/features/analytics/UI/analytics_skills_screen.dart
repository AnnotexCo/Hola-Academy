import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/custom_app_bar.dart';
import 'widgets/level_button.dart';
import 'widgets/performance_card.dart';

class AnalyticsSkillsScreen extends StatelessWidget {
  const AnalyticsSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: 'Analytics'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                LevelSelector(),
                SizedBox(height: 20.h),
                PerformanceCard(
                  title: 'Freestyle Stroke',
                  icon: Icons.pool,
                  score: '0/10',
                ),
                SizedBox(height: 20.h),
                PerformanceCard(
                  title: 'Time Management',
                  icon: Icons.timer,
                  score: '0/10',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LevelSelector extends StatelessWidget {
  const LevelSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLevelButton('Level A', true),
        buildLevelButton('Level B', false),
        buildLevelButton('Level D', true),
      ],
    );
  }
}
