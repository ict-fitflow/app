import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/ui/modals/device_manager.dart';
import 'package:fitflow/ui/tabs/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  late BluetoothProvider bluetooth;

  static const List<Widget> _widgetOptions = <Widget>[
    PourTab(),
    RecipeTab(),
    StatsTab(),
    SettingsTab()
  ];

  bool _is_connected = false;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
    bluetooth.addListener(_bluetooth_changes);
  }

  @override
  void dispose() {
    super.dispose();
    bluetooth.removeListener(_bluetooth_changes);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('FitFlow'),
            IconButton(
              onPressed: () => _open_devices_manager(context),
              icon: Badge(
                backgroundColor: _is_connected ? Colors.green : Colors.red,
                child: const Icon(Icons.devices),
              )
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.balance),
            label: 'Pour',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Recipe',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Stats',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _open_devices_manager(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => const DeviceManager()
    );
  }

  void _bluetooth_changes() {
    setState(() {
      _is_connected = bluetooth.isConnected;
      print(_is_connected);
    });
  }
}
