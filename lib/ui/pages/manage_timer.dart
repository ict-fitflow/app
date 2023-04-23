import 'package:fitflow/class/ingredient.dart';
import 'package:fitflow/class/pouring_config.dart';
import 'package:fitflow/mocks/pouring_config.dart';
import 'package:fitflow/ui/modals/add_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class ManageTimerPage extends StatefulWidget {
  const ManageTimerPage({Key? key}) : super(key: key);

  @override
  State<ManageTimerPage> createState() => _ManageTimerPageState();
}

class _ManageTimerPageState extends State<ManageTimerPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer manager"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add_config,
        child: const Icon(Icons.add)
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        children: <Widget>[
          for (int index = 0; index < pouring_configs.length; index += 1)
            ListTile(
              key: Key('$index'),
              title: Text('${pouring_configs[index].quantity}, ${IngredientsList[pouring_configs[index].what]}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _delete_config(index),
                    icon: const Icon(Icons.delete)
                  ),
                  ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle)
                  )
                ],
              ),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final PouringConfig item = pouring_configs.removeAt(oldIndex);
            pouring_configs.insert(newIndex, item);
          });
        },
      )
    );
  }

  void _delete_config(int index) {
    throw UnimplementedError();
  }

  void _add_config() {
    Picker mypicker = Picker(
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

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => AddConfigModal(),
    );
  }
}
