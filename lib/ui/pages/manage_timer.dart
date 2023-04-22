import 'package:fitflow/class/ingredient.dart';
import 'package:fitflow/class/pouring_config.dart';
import 'package:fitflow/mocks/pouring_config.dart';
import 'package:flutter/material.dart';

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
        onPressed: () => print("fab"),
        child: Icon(Icons.add)
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        children: <Widget>[
          for (int index = 0; index < pouring_configs.length; index += 1)
            ListTile(
              key: Key('$index'),
              title: Text('${pouring_configs[index].quantity}, ${Ingredients[pouring_configs[index].what]}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => 'delete',
                    icon: Icon(Icons.delete)
                  ),
                  ReorderableDragStartListener(
                    index: index,
                    child: Icon(Icons.drag_handle)
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
}
