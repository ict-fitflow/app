import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/mocks/pouring_config.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/modals/add_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageTimerPage extends StatefulWidget {
  const ManageTimerPage({Key? key}) : super(key: key);

  @override
  State<ManageTimerPage> createState() => _ManageTimerPageState();
}

class _ManageTimerPageState extends State<ManageTimerPage> {

  late UserProvider _user;

  @override
  void initState() {
    super.initState();
    _user = context.read<UserProvider>();
  }

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
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          return ReorderableListView(
            buildDefaultDragHandles: false,
            onReorder: _do_reorder,
            children: user.configs.map((c) {
              int index = user.configs.indexOf(c);
              return ListTile(
                key: Key('${index}'),
                title: Text('${c.toString()}'),
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
              );
            }).toList(),
          );
        }
      )
    );
  }

  void _delete_config(int index) {
    _user.delete_config(index);
  }

  void _add_config() async {
    PouringConfig? ret = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => const AddConfigModal(),
    );

    if (ret != null) {
      _user.add_config(ret);
    }
  }

  void _do_reorder(int old_index, int new_index) {
    _user.reorder_config(old_index, new_index);
  }
}
