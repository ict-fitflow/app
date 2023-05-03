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
        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Charts",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UserBarChart(
              history: user.history,
              daily_goal: user.daily_goal
            ),
            space,
            Text(
              "History",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            space,
            Column(
              children: user.history.getRange(0, 20).map((h) {
                Duration diff = DateTime.now().difference(h.date);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${h.config.calories.toInt()}: ${h.config.toString()}"),
                      Text("${humanReadableDiff(diff)}")
                    ],
                  )
                );
              }).toList()
            ),
            space,
            // Text(
            //   "Daily goal",
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Card(
            //   elevation: 4,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text("idk what to put here"),
            //         SizedBox(
            //           width: 100,
            //           height: 100,
            //           child: Stack(
            //             children: [
            //               Center(
            //                 child: Container(
            //                   width: 100,
            //                   height: 100,
            //                   child: CircularProgressIndicator(
            //                     strokeWidth: 5,
            //                     value: 0.4
            //                   ),
            //                 ),
            //               ),
            //               Center(
            //                 child: Text(
            //                     "45%",
            //                     style: Theme.of(context).textTheme.titleMedium
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   )
            // ),
            // space,
          ],
        );
      }
    );
  }
}
