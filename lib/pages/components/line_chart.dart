import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/models/dto/report_dto.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key, required this.gradientColor, required this.data, required this.type}) : super(key: key);

  final Color gradientColor;
  final List<ReportDto> data;
  final String type; // temperature or saturation

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [];
  List<FlSpot> spotList = [];

  double minY = 0;
  double maxY = 0;

  String getBottomTitle(int value) {
    String title = '';
    if (value % 2 == 0) {
      title = widget.data[(value / 2).floor()].morning_time.substring(11, 13) + 'am';
    } else {
      title = widget.data[(value / 2).floor()].afternoon_time.substring(11, 13) + 'pm';
    }
    return title;
  }

  @override
  void initState() {
    super.initState();
    gradientColors = [
      widget.gradientColor.withOpacity(0.8),
      const Color(0xffffffff),
      // widget.type == 'temperature'? const Color(0xffc3c9c7): widget.type == 'saturation'? const Color(0xffc9c8c3): const Color(0xffc9c9c4)
    ];

    double i = 0;
    spotList.clear();
    for (var report in widget.data) {
      if (widget.type == 'temperature') {
        if (i == 0) {
          minY = double.parse(report.morning_temperature);
          maxY = double.parse(report.morning_temperature);
        }
        if (report.morning_temperature != '') {
          spotList.add(FlSpot(i, double.parse(report.morning_temperature)));
          if (minY > double.parse(report.morning_temperature)) {
            minY = double.parse(report.morning_temperature);
          }
          if (maxY < double.parse(report.morning_temperature)) {
            maxY = double.parse(report.morning_temperature);
          }
        }
        i += 1;

        if (report.afternoon_temperature != '') {
          spotList.add(FlSpot(i, double.parse(report.afternoon_temperature)));
          if (minY > double.parse(report.afternoon_temperature)) {
            minY = double.parse(report.afternoon_temperature);
          }
          if (maxY < double.parse(report.afternoon_temperature)) {
            maxY = double.parse(report.afternoon_temperature);
          }
        }
        i += 1;
      } else if (widget.type == 'saturation') {
        if (i == 0) {
          minY = double.parse(report.morning_saturation);
          maxY = double.parse(report.morning_saturation);
        }
        if (report.morning_saturation != '') {
          spotList.add(FlSpot(i, double.parse(report.morning_saturation)));
          if (minY > double.parse(report.morning_saturation)) {
            minY = double.parse(report.morning_saturation);
          }
          if (maxY < double.parse(report.morning_saturation)) {
            maxY = double.parse(report.morning_saturation);
          }
        }
        i += 1;

        if (report.afternoon_saturation != '') {
          spotList.add(FlSpot(i, double.parse(report.afternoon_saturation)));
          if (minY > double.parse(report.afternoon_saturation)) {
            minY = double.parse(report.afternoon_saturation);
          }
          if (maxY < double.parse(report.afternoon_saturation)) {
            maxY = double.parse(report.afternoon_saturation);
          }
        }
        i += 1;
      } else {
        if (i == 0) {
          minY = double.parse(report.morning_breath);
          maxY = double.parse(report.morning_breath);
        }
        if (report.morning_breath != '') {
          spotList.add(FlSpot(i, double.parse(report.morning_breath)));
          if (minY > double.parse(report.morning_breath)) {
            minY = double.parse(report.morning_breath);
          }
          if (maxY < double.parse(report.morning_breath)) {
            maxY = double.parse(report.morning_breath);
          }
        }
        i += 1;

        if (report.afternoon_breath != '') {
          spotList.add(FlSpot(i, double.parse(report.afternoon_breath)));
          if (minY > double.parse(report.afternoon_breath)) {
            minY = double.parse(report.afternoon_breath);
          }
          if (maxY < double.parse(report.afternoon_breath)) {
            maxY = double.parse(report.afternoon_breath);
          }
        }
        i += 1;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 4,
      radius: const Radius.circular(2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // aspectRatio: 1.70,
        child: Container(
          width: 600,
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 16.0, left: 16.0, top: 12, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xfff4f4f4),
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: ((maxY - minY) / 4).ceil().toDouble(),
          getTextStyles: (context, value) => AppTextStyle.PD(Color(0xff585859), 11, weight: FW.medium),
          getTitles: (value) {
            return getBottomTitle(value.toInt());
          },
          margin: 10,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => AppTextStyle.PD(Color(0xffa0a0a0), 11, weight: FW.medium),
          getTitles: (value) {
            return value.toString();
          },
          reservedSize: 32,
          // margin: 12,
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 13,
      minY: minY.floor() - 1.0,
      maxY: maxY.ceil() + 1.0,
      lineBarsData: [
        LineChartBarData(
          spots: spotList,
          isCurved: false,
          colors: [widget.gradientColor],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
            gradientColors.map((color) => color.withOpacity(0.8)).toList(),
            gradientFrom: const Offset(0, 0),
            gradientTo: const Offset(0, 1)

          ),
        ),
      ],
    );
  }
}