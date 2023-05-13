import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/widgets/text.dart';
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
  late UserProvider user;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
    user = context.read<UserProvider>();
    _scan();
  }

  @override
  void dispose() {
    super.dispose();
    bluetooth.stop_scan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetooth, child) {
        List<ListTile> paired = [];
        List<ListTile> unpaired = [];

        for (BluetoothDiscoveryResult dev in bluetooth.results) {
          String? name = dev.device.name;
          String address = dev.device.address;
          String text = (name == null) ? address : name;
          if (user.is_paired_device(address)) {
            paired.add(
              ListTile(
                horizontalTitleGap: 10,
                onTap: () => _connect(dev),
                title: Text(text),
                leading: (dev.device.isConnected) ? const Icon(Icons.bluetooth_connected) : const Icon(Icons.bluetooth_disabled_outlined),
                minLeadingWidth : 2,
                dense: true,
                visualDensity: const VisualDensity(vertical: 0, horizontal: -2)
              )
            );
          }
          else {
            unpaired.add(
              ListTile(
              horizontalTitleGap: 10,
                onTap: () => _connect(dev),
                title: Text(text),
                leading: (dev.device.isConnected) ? const Icon(Icons.bluetooth_connected) : const Icon(Icons.bluetooth_disabled_outlined),
                minLeadingWidth : 2,
                dense: true,
                visualDensity: const VisualDensity(vertical: 0, horizontal: -2)
              )
            );
          }
        }

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Device manager'),
              if (bluetooth.scanning) const CircularProgressIndicator()
              else IconButton(onPressed: _scan, icon: const Icon(Icons.autorenew))
            ],
          ),
          scrollable: true,
          content: Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextSmall("Paired device"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: paired
                    ),
                  ),
                  const TextSmall("Available device"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: unpaired
                    ),
                  )
                ],
              )
          )
        );
      }
    );
  }

  _connect(BluetoothDiscoveryResult device) async {
    print(device);
    bool toadd = await bluetooth.connect(device.device.address);
    if (toadd) {
      user.add_bluetooth_device(device.device.address);
    }
  }

  void _scan() {
    bluetooth.scan();
  }
}