import 'package:fitflow/classes/params.dart';
import 'package:fitflow/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class DailyGoalModal extends StatefulWidget {
  const DailyGoalModal({Key? key}) : super(key: key);

  @override
  State<DailyGoalModal> createState() => _DailyGoalModalState();
}

class _DailyGoalModalState extends State<DailyGoalModal> {

  late Picker mypicker;
  late UserProvider userprofile;

  @override
  void initState() {
    super.initState();
    userprofile = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    mypicker = Picker(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selecteds: [ KcalList.indexOf(userprofile.daily_goal_intake) ],
      adapter: PickerDataAdapter<String>(
        pickerData: [
          KcalList
        ],
        isArray: true
      ),
      hideHeader: false,
      title: const Text("Please Select"),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        _confirm_goals();
      }
    );

    return mypicker.makePicker();
  }

  void _confirm_goals() {
    userprofile.daily_goal_intake = KcalList[mypicker.selecteds[0]];
  }
}
