import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3)
  ];

  final Color mainGridLineColor = Colors.white10;
  final Color leftBarColor = Color(0xFFFFC300);
  final Color rightBarColor = Color(0xFFE80054);

  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // AspectRatio(
        //   aspectRatio: 1,
        //   child: Padding(
        //     padding: const EdgeInsets.only(
        //       right: 18,
        //       left: 12,
        //       top: 24,
        //       bottom: 12,
        //     ),
        //     child: LineChart(mainData()),
        //   ),
        // ),
        AspectRatio(
          aspectRatio: 1,
          child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          makeTransactionsIcon(),
          const SizedBox(
          width: 38,
          ),
          const Text(
          'Transactions',
          style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(
          width: 4,
          ),
          const Text(
          'state',
          style: TextStyle(color: Color(0xff77839a), fontSize: 16),
          ),
          ],
          ),
          const SizedBox(
          height: 38,
          ),
          Expanded(
          child: BarChart(
          BarChartData(
          maxY: 20,
          barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.grey,
          getTooltipItem: (a, b, c, d) => null,
          ),
          touchCallback: (FlTouchEvent event, response) {
          if (response == null || response.spot == null) {
          setState(() {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
          });
          return;
          }

          touchedGroupIndex = response.spot!.touchedBarGroupIndex;

          setState(() {
          if (!event.isInterestedForInteractions) {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
          return;
          }
          showingBarGroups = List.of(rawBarGroups);
          if (touchedGroupIndex != -1) {
          var sum = 0.0;
          for (final rod
          in showingBarGroups[touchedGroupIndex].barRods) {
          sum += rod.toY;
          }
          final avg = sum /
          showingBarGroups[touchedGroupIndex]
              .barRods
              .length;

          showingBarGroups[touchedGroupIndex] =
          showingBarGroups[touchedGroupIndex].copyWith(
          barRods: showingBarGroups[touchedGroupIndex]
              .barRods
              .map((rod) {
          return rod.copyWith(
            toY: avg, color: Color(0xFFFF683B));
          }).toList(),
          );
          }
          });
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
          getTitlesWidget: bottomTitle,
          reservedSize: 42,
          ),
          ),
          leftTitles: AxisTitles(
          sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: 1,
          getTitlesWidget: leftTitle,
          ),
          ),
          ),
          borderData: FlBorderData(
          show: false,
          ),
          barGroups: showingBarGroups,
          gridData: FlGridData(show: false),
          ),
          ),
          ),
          const SizedBox(
          height: 12,
          ),
          ],
          ),
          ),
        )
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: TextButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       'avg',
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget bottomTitle(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitle(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
          );
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
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitle,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitle,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
