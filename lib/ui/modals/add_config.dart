import 'package:fitflow/classes/params.dart';
import 'package:fitflow/classes/pouring_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class AddConfigModal extends StatefulWidget {
  const AddConfigModal({Key? key}) : super(key: key);

  @override
  State<AddConfigModal> createState() => _AddConfigModalState();
}

class _AddConfigModalState extends State<AddConfigModal> {

  late Picker mypicker;

  PouringConfig current = PouringConfig(10, 0);

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
      hideHeader: false,
      title: const Text("Please Select"),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onSelect: (Picker picker, int c, List value) {
      }
    );
    mypicker.selecteds = current.getConfig();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mypicker.makePicker(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _add_config,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text("Add")
            ),
          ),
        )
      ]
    );
  }

  void _add_config() {
    throw UnimplementedError("Add config");
  }
}
