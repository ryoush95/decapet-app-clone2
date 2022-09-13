import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';

import 'h14.dart';

class CustomLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: LineChart(
        mainData(),
      ),);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColor_Red,
            strokeWidth: 50,
          );
        },
      ),
    );
  }
}
