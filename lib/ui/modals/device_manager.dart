import 'package:fitflow/providers/bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
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
    _scan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetooth, child) {
        Widget content = (bluetooth.isEnabled == false) ? const Icon(Icons.bluetooth_disabled) :
          ListView(
            children: bluetooth.results.map(
              (dev) {
                String? name = dev.device.name;
                String address = dev.device.address;

                String text = (name == null) ? address : name;
                return ListTile(
                  onTap: () => _connect(dev),
                  title: Text(text),
                  leading: (dev.device.isConnected) ? Icon(Icons.bluetooth_connected) : Icon(Icons.bluetooth_disabled_outlined),
                  minLeadingWidth : 10,
                );
              }
            ).toList()
          );

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Device manager'),
              if (bluetooth.scanning) const CircularProgressIndicator()
              else IconButton(onPressed: _scan, icon: const Icon(Icons.autorenew))
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

  _connect(BluetoothDiscoveryResult device) {
    print(device);
    bluetooth.connect(device.device.address);
  }

  void _scan() {
    bluetooth.scan();
  }
}
