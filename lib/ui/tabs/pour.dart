import 'package:fitflow/classes/ingredient.dart';
import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/mocks/pouring_config.dart';
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
  PouringConfig current = PouringConfig(20, 0);
  late Picker mypicker;

  @override
  Widget build(BuildContext context) {

    mypicker = Picker(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selecteds: [20, 0],
      adapter: PickerDataAdapter<String>(
          pickerData: [
            GramsList,
            IngredientsList
          ],
          isArray: true
      ),
      hideHeader: true,
      // delimiter: [
      //   PickerDelimiter(
      //       child: Container(
      //         width: 30.0,
      //         alignment: Alignment.center,
      //         child: Icon(Icons.more_vert),
      //       ))
      // ],
      title: const Text("Please Select"),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onSelect: (Picker picker, int c, List value) {
        // TODO: do something
      }
    );
    mypicker.selecteds = current.getConfig();

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
                  child: const Text("Manage")
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pouring_configs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => changeValue(pouring_configs[index]),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${pouring_configs[index].quantity}"),
                          Text("${IngredientsList[pouring_configs[index].what]}")
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

  void changeValue(PouringConfig config) {
    setState(() {
      current.setConfig(config.getConfig());
      current.quantity--;
      mypicker.selecteds = current.getConfig();
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
