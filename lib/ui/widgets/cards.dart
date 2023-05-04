import 'package:fitflow/classes/user.dart';
import 'package:fitflow/ui/widgets/text.dart';
import 'package:flutter/material.dart';

class CardHistory extends StatelessWidget {
  PourHistory entry;

  CardHistory ({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration diff = DateTime.now().difference(entry.date);

    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextMedium("+${entry.config.calories.toInt()} cal", color: Colors.green),
              TextMedium("${entry.config}"),
              TextSmall(humanReadableDiff(diff), color: Colors.grey,)
            ],
          ),
        )
    );
  }

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
}