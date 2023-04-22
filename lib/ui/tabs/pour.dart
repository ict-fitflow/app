import 'package:fitflow/ui/pages/manage_timer.dart';
import 'package:fitflow/ui/pages/pouring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class PourTab extends StatefulWidget {
  const PourTab({Key? key}) : super(key: key);

  @override
  State<PourTab> createState() => _PourTabState();
}

class _PourTabState extends State<PourTab> {
  int _currentValue = 50;
  late Picker mypicker;

  @override
  Widget build(BuildContext context) {

    final List productList = ["Oil", "Milk"];
    final List gramsList = List<int>.generate(100, (i) => i + 1);

    mypicker = Picker(
        selecteds: [20, 0],
        adapter: PickerDataAdapter<String>(
            pickerData: [
              gramsList,
              productList
            ],
            isArray: true
        ),
        hideHeader: true,
        delimiter: [
          PickerDelimiter(
              child: Container(
                width: 30.0,
                alignment: Alignment.center,
                child: Icon(Icons.more_vert),
              ))
        ],
        title: const Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onSelect: (Picker picker, int c, List value) {
          print(picker.getSelectedValues());
        }
    );
    mypicker.selecteds = [20, 0];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            mypicker.makePicker(),
            // const Divider(),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
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
                          Text("10"),
                          Text("olio")
                        ],
                      ),
                    ),
                  ),
                );
                // const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              }
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

  void startPouring() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PouringPage())
    );
  }
}
