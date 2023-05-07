import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothProvider extends ChangeNotifier {

  List<BluetoothDiscoveryResult> results = [];
  bool _scanning = false;
  bool _isEnabled = false;
  late FlutterBluetoothSerial instance;
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;

  BluetoothProvider() {
    _init();
  }

  void _init() async {
    instance = FlutterBluetoothSerial.instance;
    _isEnabled = (await instance.isEnabled)!;

    instance.onStateChanged().listen((state) {
      _isEnabled = state.isEnabled;
      notifyListeners();
    });
  }

  void scan() {
    results = [];
    _scanning = true;
    _streamSubscription = instance.startDiscovery().listen((r) {
      final existingIndex = results.indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0)
        results[existingIndex] = r;
      else
        results.add(r);
      notifyListeners();
    });

    _streamSubscription!.onDone(() {
      _scanning = false;
      notifyListeners();
    });
  }


  bool get scanning => _scanning;
  get isEnabled => _isEnabled;

}

