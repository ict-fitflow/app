import 'package:fitflow/classes/params.dart';
import 'package:fitflow/classes/user.dart';
import 'package:fitflow/ui/widgets/cards.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserBarChart extends StatefulWidget {
  DailyGoal daily_goal;
  List<PourHistory> history;

  UserBarChart({Key? key, required this.daily_goal, required this.history}) : super(key: key);

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
  List<List<PourHistory>> week_history = [];
  // int week_index = 1;

  int touchedGroupIndex = -1;
  double maxY = KcalList.last;
  late double maxY_opt;

  @override
  void initState() {
    super.initState();

    // due performance motivation
    maxY_opt = downscale(maxY).toDouble();

    _clear_week_data();
    _prepare_data();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
                            touchCallback: _touch_callback,
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
                                reservedSize: 30,
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
        ),
        if (touchedGroupIndex != -1)
          Text(
            "Activities",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        if (touchedGroupIndex != -1)
          Column(
            children: week_history[touchedGroupIndex].map(
              (e) => CardHistory(entry: e)
            ).toList()
          )
      ],
    );
  }

  void _prepare_data() {
    // TODO: make weeks pagination
    int index = 0;
    int weekday = DateTime.now().weekday;

    for (int d = 0; d < weekday; d++) {
      final now = DateTime.now();
      final diff = Duration(days: d, hours: now.hour, minutes: now.minute);
      DateTime i_days_ago = now.subtract(diff);
      List<PourHistory> toSave = [];
      double count = 0;

      while (index < widget.history.length && widget.history[index].date.isAfter(i_days_ago)) {
        toSave.add(widget.history[index]);
        count += widget.history[index].config.calories;
        index++;
      }

      int i = weekday - 1 - d;
      week_history[i].addAll(toSave);
      showingBarGroups.add(makeGroupData(i, downscale(count).toDouble()));
    }
    showingBarGroups = List.from(showingBarGroups.reversed);

    for (int i = weekday; i < 7; i++) {
      showingBarGroups.add(makeGroupData(i, 0));
    }
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
    // int index = titles.length - 1 - value.toInt();
    int index = value.toInt();
    final Widget text = Text(
      titles[index],
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

  void _clear_week_data() {
    week_history.clear();
    for (int i = 0; i < 7; i++) {
      week_history.add([]);
    }
  }

  void _touch_callback(FlTouchEvent event, BarTouchResponse? response) {
    if (!(event is FlTapUpEvent)) return;
    if (response == null || response.spot == null) {
      setState(() {
        touchedGroupIndex = -1;
      });
      return;
    }
    setState(() {
      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
    });
  }
}