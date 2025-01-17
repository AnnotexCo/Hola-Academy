import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_manager.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 35.w,
              getTitlesWidget: (value, meta) {
                if (value == 0) return Container(); // Hide 0
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: ColorManager.errorRedColor,
                    fontSize: 12.sp,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  '1/${value.toInt() + 1}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 4),
              FlSpot(1, 3),
              FlSpot(2, 7),
              FlSpot(3, 5),
              FlSpot(4, 7),
              FlSpot(5, 5),
            ],
            isCurved: true,
            color: ColorManager.primaryOrangeColor,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withValues(alpha: 0.1),
            ),
          ),
        ],
        minY: 1, // Changed from 0 to 1
        maxY: 10,
        lineTouchData:
            LineTouchData(enabled: false), // Disable touch interaction
      ),
    );
  }
}
