import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  Stream<List<ScanResult>> scan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    return FlutterBluePlus.scanResults;
  }

  Stream<BluetoothAdapterState> adapterState() {
    return FlutterBluePlus.adapterState;
  }

  void stop() {
    FlutterBluePlus.stopScan();
  }
}
