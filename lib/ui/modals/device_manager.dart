import 'package:fitflow/providers/bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceManager extends StatefulWidget {
  const DeviceManager ({Key? key}) : super(key: key);

  @override
  State<DeviceManager> createState() => _DeviceManagerState();
}

class _DeviceManagerState extends State<DeviceManager> {

  late BluetoothProvider bluetooth;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
    bluetooth.scan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetooth, child) {
        Widget content = (bluetooth.isEnabled == false) ? Icon(Icons.bluetooth_disabled) :
          ListView.builder(
            itemCount: bluetooth.results.length,
            itemBuilder: (context, index) {
              String? name = bluetooth.results[index].device.name;
              String address = bluetooth.results[index].device.address;

              String text = (name == null) ? address : name;
              return ListTile(
                onTap: () => print(text),
                title: Text(text),
              );
            }
          );

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Device manager'),
              if (bluetooth.scanning) const CircularProgressIndicator()
            ],
          ),
          content: Container(
              height: 300,
              child: content
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}
