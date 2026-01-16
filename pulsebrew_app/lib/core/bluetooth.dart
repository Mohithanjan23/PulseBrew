import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  /// Start scanning for BLE devices
  static Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
    );
  }

  /// Stop scanning
  static Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  /// Stream of scan results
  static Stream<List<ScanResult>> get scanResults =>
      FlutterBluePlus.scanResults;

  /// Bluetooth adapter state (on/off)
  static Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;
}
