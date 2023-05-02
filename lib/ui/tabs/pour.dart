import 'package:fitflow/classes/params.dart';
import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/pages/manage_timer.dart';
import 'package:fitflow/ui/pages/pouring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

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
            IngredientsList.map((e) => e.name).toList()
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
      onSelect: (Picker picker, int c, List<int> value) {
        current.setConfig(value);
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
            Consumer<UserProvider>(
              builder: (context, user, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.configs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => changeValue(user.configs[index]),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${user.configs[index].quantity}"),
                              Text("${user.configs[index].what}")
                            ],
                          ),
                        ),
                      ),
                    );
                    // const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                  }
                );
              }
            )
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
      MaterialPageRoute(builder: (context) => PouringPage(config: current))
    );
  }
}
