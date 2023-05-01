import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/charts/bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String humanReadableDiff(Duration diff) {
  if (diff.inDays > 0) {
    return "${diff.inDays}d";
  }
  else if (diff.inHours > 0) {
    return "${diff.inHours}h";
  }
  else {
    return "${diff.inMinutes}m";
  }
}

class StatsTab extends StatefulWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {

  final space = const Padding(padding: EdgeInsets.symmetric(vertical: 6));

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "History",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            space,
            Column(
              children: user.history.map((h) {
                Duration diff = DateTime.now().difference(h.date);
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${h.config.toString()}"),
                    Text("${humanReadableDiff(diff)}")
                  ],
                );
              }).toList()
            ),
            space,
            Text(
              "Charts",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UserBarChart( daily_goal: user.daily_goal )
          ],
        );
      }
    );
  }
}
