import 'package:fitflow/classes/macronutrients.dart';
import 'package:fitflow/ui/widgets/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartColors {

  static const Color carbohydrates = Colors.orange;
  static const Color protein = Colors.lightGreen;
  static const Color fats = Colors.purple;

}

class RecipePieChart extends StatefulWidget {
  MacroNutrients nutrients;

  RecipePieChart({Key? key, required this.nutrients}) : super(key: key);

  @override
  State<RecipePieChart> createState() => _RecipePieChartState();
}

class _RecipePieChartState extends State<RecipePieChart> {

  late List<double> values, toshow;
  late List<int> percentage;

  @override
  void initState() {
    super.initState();
    _prepare_chart_data();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 20,
              sections: showingSections(),
              startDegreeOffset: -90
            ),
          ),
        ),
        Indicator(
          color: PieChartColors.carbohydrates,
          text: 'Carbo',
          content_text: "${percentage[0]}%",
        ),
        Indicator(
          color: PieChartColors.protein,
          text: 'Proteins',
          content_text: "${percentage[1]}%",
        ),
        Indicator(
          color: PieChartColors.fats,
          text: 'Fats',
          content_text: "${percentage[2]}%",
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      const radius = 6.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: PieChartColors.carbohydrates,
            value: toshow[i],
            title: "",
            radius: radius
          );
        case 1:
          return PieChartSectionData(
            color: PieChartColors.protein,
            value: toshow[i],
            title: "",
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: PieChartColors.fats,
            value: toshow[i],
            title: "",
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

  void _prepare_chart_data() {
    double cal_c = widget.nutrients.cal_carbohydrates;
    double cal_p = widget.nutrients.cal_proteins;
    double cal_f = widget.nutrients.cal_fats;

    values = [cal_c, cal_f, cal_p];

    double sum = values.reduce((value, element) => value + element);
    toshow = values.map((v) => v * 100 / sum).toList();
    percentage = values.map((v) => v * 100 ~/ sum).toList();
    int s = percentage.reduce((value, element) => value + element);
    if (s != 100) {
      percentage[0] += 100 - s;
    }
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.content_text,
    this.size = 10,
    this.textColor,
  });
  final Color color;
  final String text, content_text;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.withOpacity(0.5),
        ),
        child: Column(
          children: <Widget>[
            TextTiny(text),
            TextMedium(content_text)
          ],
        ),
      )
    );
  }
}