import 'package:fitflow/classes/history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartColors {

  static const Color carbohydrates = Colors.orange;
  static const Color protein = Colors.lightGreen;
  static const Color fats = Colors.purple;

}

class UserPieChart extends StatefulWidget {
  UserHistory history;

  UserPieChart({Key? key, required this.history}) : super(key: key);

  @override
  State<UserPieChart> createState() => _UserPieChartState();
}

class _UserPieChartState extends State<UserPieChart> {

  late List<double> values;

  @override
  void initState() {
    super.initState();
    _prepare_chart_data();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                  startDegreeOffset: -90
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Indicator(
                color: PieChartColors.carbohydrates,
                text: 'Carbohydrates'
              ),
              Indicator(
                color: PieChartColors.protein,
                text: 'Proteins'
              ),
              Indicator(
                color: PieChartColors.fats,
                text: 'Fats'
              )
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double sum = values[0] + values[1] + values[2];
    late List<double> toshow;
    if (sum == 0) {
      toshow = [100, 0, 0];
    }
    else {
      toshow = values.map((v) => v * 100 / sum).toList();
    }
    return List.generate(3, (i) {
      const fontSize = 16.0;
      const radius = 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: PieChartColors.carbohydrates,
            value: toshow[i],
            title: '${toshow[i].toInt()}%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: PieChartColors.protein,
            value: toshow[i],
            title: '${toshow[i].toInt()}%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: PieChartColors.fats,
            value: toshow[i],
            title: '${toshow[i].toInt()}%',
            radius: radius,
            titleStyle:  const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  void _prepare_chart_data() {
    double cal_c = 0;
    double cal_p = 0;
    double cal_f = 0;

    for (int d = 0; d < 7; d++) {
      cal_c += widget.history.week_history[d].cal_carbohydrates;
      cal_p += widget.history.week_history[d].cal_proteins;
      cal_f += widget.history.week_history[d].cal_fats;
    }
    // TODO: fix that shit
    values = [cal_c, cal_f, cal_p];
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}