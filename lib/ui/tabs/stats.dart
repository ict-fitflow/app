import 'dart:math';

import 'package:fitflow/classes/history.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/charts/bar.dart';
import 'package:fitflow/ui/charts/pie.dart';
import 'package:fitflow/ui/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {

  final space = const Padding(padding: EdgeInsets.symmetric(vertical: 6));
  late UserProvider user;
  late UserHistory history;

  @override
  void initState() {
    super.initState();
    user = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {

        _prepare_data();

        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Calories",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UserBarChart(
              history: history,
              daily_goal: user.daily_goal
            ),
            space,
            Text(
              "Macro nutrients",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UserPieChart(
              history: history,
            ),
            space,
            Text(
              "History",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            space,
            Column(
              children: user.history.getRange(0, min(5, user.history.length)).map((h) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: CardHistory(entry: h)
                );
              }).toList()
            ),
          ],
        );
      }
    );
  }

  void _prepare_data() {
    // TODO: make weeks pagination
    history = UserHistory(user.history);
  }
}

