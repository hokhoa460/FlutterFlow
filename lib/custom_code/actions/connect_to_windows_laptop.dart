// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<void> connectToWindowsLaptop() async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  try {
    // Specific Bluetooth MAC address of the Windows laptop
    String windowsLaptopMacAddress = "28-16-A8-57-72-2D";

    // Initialize Bluetooth
    FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;

    // Start scanning for devices
    FlutterBluePlus.startScan(timeout: Duration(seconds: 10));

    // Listen for scan results
    await for (var result in FlutterBluePlus.scanResults) {
      for (ScanResult scanResult in result) {
        // Check if the scanned device matches the Windows laptop's MAC address
        if (scanResult.device.id.toString() == windowsLaptopMacAddress) {
          // Stop scanning once the device is found
          await FlutterBluePlus.stopScan();

          try {
            // Attempt to connect to the device
            await scanResult.device.connect();
            print("Connected to Windows Laptop");

            // Discover services and characteristics
            List<BluetoothService> services =
                await scanResult.device.discoverServices();
            for (BluetoothService service in services) {
              for (BluetoothCharacteristic characteristic
                  in service.characteristics) {
                // Implement specific interaction with Windows laptop
                // Example: Read or write characteristics if needed
                // await characteristic.read();
                // await characteristic.write(utf8.encode("Your command"));
              }
            }
          } catch (connectError) {
            print("Connection failed: $connectError");
          }
        }
      }
    }
  } catch (e) {
    print("Error in Bluetooth connection: $e");
  }
}

/// MODIFY CODE ONLY ABOVE THIS LINE
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
