import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fitflow/classes/pouring_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

enum DeviceState { READY, POURING }

class PourState {
  final PouringConfig config;
  final List<double> _status = [];
  bool _finished = false;

  PourState(this.config);

  void add(double val) {
    _status.add(val);
  }

  void finish() {
    _finished = true;
  }

  bool get finished => _finished;
  List<double> get status => _status;
}

class BluetoothProvider extends ChangeNotifier {

  List<BluetoothDiscoveryResult> results = [];
  bool _scanning = false;
  bool _isEnabled = false;
  BluetoothConnection? _device;
  DeviceState state = DeviceState.READY;
  PourState? pour;

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

      if (existingIndex >= 0) {
        results[existingIndex] = r;
      }
      else {
        results.add(r);
      }
      notifyListeners();
    });

    _streamSubscription!.onDone(() {
      _scanning = false;
      notifyListeners();
    });
  }

  void connect(String address) async {
    if (_device != null) return;
    try {
      _device = await BluetoothConnection.toAddress(address);
      print('Connected to the device');

      StreamSubscription stream = _device!.input!.listen(receive);

      stream.onDone(() {
        _device = null;
        notifyListeners();
      });

      stream.onError((e) {
        print("error $e");
        _device = null;
        notifyListeners();
      });

      notifyListeners();
    }
    catch (exception) {
      print('Cannot connect, exception occured');
      _device = null;
    }
  }

  void do_pour(PouringConfig config) {
    pour = PourState(config);
    String payload = "pour ${config.quantity}";
    _device!.output.add(ascii.encode(payload));
    state = DeviceState.POURING;
  }

  void receive(Uint8List data) {
    String payload = ascii.decode(data);
    switch (state) {
      case DeviceState.READY:
        print("ERRORACCIO");
        break;
      case DeviceState.POURING:
        if (payload == "STOP") {
          pour!.finish();
          state = DeviceState.READY;
        }
        else {
          double val = double.parse(payload);
          pour!.add(val);
        }
        break;
    }
    print('Data incoming: ${payload}');
  }

  PourState? get pour_state => pour;
  bool get scanning => _scanning;
  get isEnabled => _isEnabled;

}

