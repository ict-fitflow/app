import 'dart:math';

import 'package:fitflow/classes/params.dart';
import 'package:fitflow/classes/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserBarChart extends StatefulWidget {
  DailyGoal daily_goal;

  UserBarChart({Key? key, required this.daily_goal}) : super(key: key);

  @override
  State<UserBarChart> createState() => _UserBarChartState();
}

class _UserBarChartState extends State<UserBarChart> {

  List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3)
  ];

  final Color mainGridLineColor = Colors.white10;
  final Color leftBarColor = Color(0xFFFFC300);
  final Color rightBarColor = Color(0xFFE80054);

  final double width = 7;

  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;
  double maxY = KcalList.last;
  late double maxY_opt;

  @override
  void initState() {
    super.initState();

    // due performance motivation
    maxY_opt = downscale(maxY).toDouble();

    var rng = Random();
    for (var i = 0; i < 7; i++) {
      double v = rng.nextInt(maxY.toInt()).toDouble();
      showingBarGroups.add(makeGroupData(i, downscale(v).toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: maxY_opt,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (a, b, c, d) => null,
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            setState(() {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(showingBarGroups);
                            });
                            return;
                          }
                          touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                          // TODO: show what customer pour in that day
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: downscale(100).toDouble(),
                        getDrawingHorizontalLine: (value) {
                          if (widget.daily_goal.enabled && upscale(value) == widget.daily_goal.intake) {
                            return FlLine(
                              color: Colors.red,
                              strokeWidth: 4,
                            );
                          }
                          else {
                            return FlLine(strokeWidth: 0);
                          }
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  int downscale(double v) {
    return v ~/ 100;
  }

  int upscale(double v) {
    return v.toInt() * 100;
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (upscale(value) % 500 == 0) {
      text = "${(upscale(value) / 1000)}k";
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
      ],
    );
  }
}
