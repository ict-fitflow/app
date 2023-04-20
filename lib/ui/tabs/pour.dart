import 'package:fitflow/ui/pages/manage_timer.dart';
import 'package:fitflow/ui/pages/pouring.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class PourTab extends StatefulWidget {
  const PourTab({Key? key}) : super(key: key);

  @override
  State<PourTab> createState() => _PourTabState();
}

class _PourTabState extends State<PourTab> {
  int _currentValue = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            NumberPicker(
              value: _currentValue,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) => setState(() => _currentValue = value),
              itemWidth: double.infinity,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Most used"),
                TextButton(
                  onPressed: manageTimer,
                  child: const Text("Add")
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeValue(10),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Olio"),
                    Text("10")
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeValue(20),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Farina"),
                    Text("20")
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeValue(50),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Vino"),
                    Text("50")
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: startPouring,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
            ),
            child: const Text("Start")
          ),
        ),
      ],
    );
  }

  void changeValue(int value) {
    setState(() {
      _currentValue = value;
    });
  }

  void manageTimer() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ManageTimerPage())
    );
  }

  void startPouring() {Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PouringPage())
  );
  }
}
