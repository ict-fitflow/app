import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fitflow/classes/pouring_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

enum DeviceState { READY, POURING }

class PourState {
  final PouringConfig config;
  late final StreamController<double> _stream;
  bool _finished = false;

  PourState(this.config) {
    _stream = StreamController<double>(
      onPause: () => print('Paused'),
      onResume: () => print('Resumed'),
      onCancel: () => print('Cancelled'),
      onListen: () => print('Listens'),
    );
  }

  void add(double val) {
    if (val >= 0 && val <= config.quantity) {
      val = val / config.quantity;
      _stream.add(val);
    }
  }

  void finish() {
    _finished = true;
    _stream.close();
  }

  bool get finished => _finished;
  Stream<double> get stream => _stream.stream;
}

class BluetoothProvider extends ChangeNotifier {

  List<BluetoothDiscoveryResult> results = [];
  bool _scanning = false;
  bool _isEnabled = false;
  BluetoothConnection? _device;
  DeviceState state = DeviceState.READY;
  PourState? _pour;

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

  void stop_scan() {
    _streamSubscription!.cancel();
  }

  Future<bool> connect(String address) async {
    if (_device != null) return false;
    try {
      _device = await BluetoothConnection.toAddress(address);
      notifyListeners();
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
      return true;
    }
    catch (exception) {
      print('Cannot connect, exception occured');
      _device = null;
      return false;
    }
  }

  Stream<double> do_pour(PouringConfig config) {
    _pour = PourState(config);
    String payload = "pour ${config.quantity}";
    _device!.output.add(ascii.encode(payload));
    state = DeviceState.POURING;
    return _pour!.stream;
  }

  void receive(Uint8List data) {
    String payload = ascii.decode(data);
    switch (state) {
      case DeviceState.READY:
        print("ERRORACCIO");
        break;
      case DeviceState.POURING:
        if (payload == "STOP") {
          _pour!.finish();
          state = DeviceState.READY;
        }
        else {
          double val = double.parse(payload);
          print(val);
          _pour!.add(val);
        }
        break;
    }
    // print('Data incoming: ${payload}');
  }

  PourState? get pour_state => _pour;
  bool get scanning => _scanning;
  bool get isEnabled => _isEnabled;
  bool get isConnected => (_device != null) ? true : false;

}

