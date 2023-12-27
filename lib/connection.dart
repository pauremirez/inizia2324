import 'dart:convert';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:inizia2324/deviceScreen.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> connectedDevices = [];
  List<BluetoothDevice> discoveredDevices = [];
  late List<BluetoothService> services;

  @override
  void initState() {
    super.initState();
    _startBluetoothScan();
  }

  void _checkBluetooth() {
    BluetoothEnable.enableBluetooth.then((result) {
      if (result == "true") {
        // Bluetooth has been enabled
      } else if (result == "false") {
        // Bluetooth has not been enabled
      }
    });
  }

  void _updateDeviceState(BluetoothDevice device) {
    setState(() {
      connectedDevices.add(device);
      discoveredDevices.remove(device);
    });
  }

  Future<void> _connectDevice(BluetoothDevice device) async {
    flutterBlue.stopScan();
    try {
      // Perform operations on the connected device here.
      if (!connectedDevices.contains(device)) {
        await device.connect().then((value) => _updateDeviceState(device));
      }
    } catch (e) {
      // Handle connection errors.
    }
  }

  void _startBluetoothScan() {
    _checkBluetooth();
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.device.name.contains("INIZIA")) {
          if (!connectedDevices.contains(result.device)) {
            //No está en conectados
            if (!discoveredDevices.contains(result.device)) {
              setState(() {
                discoveredDevices.add(result.device);
              });
            }
          } else {
            print("hola");
            //Ya está en el listado de conectados
          }
        }
      }
    });
  }

  // Discover services & read/write from CHARACTERISTICS
  Future<void> _transferDataCharacteristics(BluetoothDevice device) async {
    services = await device.discoverServices();
    services.forEach((service) async {
      // Si es el servicio del Android BLE
      if (service.uuid.toString() == '4fafc201-1fb5-459e-8fcc-c5c9c331914b') {
        //Comprobamos que estamos trabajando en la Characteristic correcta
        // Reads all characteristics
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.toString() == 'beb5483e-36e1-4688-b7f5-ea07361b26a8') {
            // La ponemos a FALSE primero y luego la cambiamos a true --> AJUATE

            // READS from a characteristic
            //    List<int> value = await c.read();
            //    print('READING FROM DEVICE:  $value');

            // WRITES to a characteristic
            //await c.write([0x12, 0x34]);
            await c.write(utf8.encode("176,224,230"), withoutResponse: true);
          }
        }
      }
    });
  }

  notify() async {
    // ignore: avoid_function_literals_in_foreach_calls
    services.forEach((service) async {
      // Si es el servicio del Android BLE
      if (service.uuid.toString() == '4fafc201-1fb5-459e-8fcc-c5c9c331914b') {
        //Comprobamos que estamos trabajando en la Characteristic correcta
        // Reads all characteristics
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.toString() == 'beb5483e-36e1-4688-b7f5-ea07361b26a8') {
            await c.setNotifyValue(true);
            c.value.listen((value) {
              // do something with new value
              List<int> readValue = value;
              print('READING FROM DEVICE:  $readValue.lenght');
            });
          }
        }
      }
    });
  }

  Widget _buildDeviceList(
      String title, Icon icon, List<BluetoothDevice> devices) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(devices[index].name),
                subtitle: Text(devices[index].id.toString()),
                onTap: () {
                  // Implement your connection logic here
                  // For simplicity, you can just print the selected device

                  if (!connectedDevices.contains(devices[index])) {
                    _connectDevice(devices[index]);
                    print(
                        'Trying to connect the device: ${devices[index].name}');
                  } else {
                    _transferDataCharacteristics(devices[index]);
                    // ya está conectado. Accedemos a su configuración
                    print(
                        'CONFIGURACIÓN POR DEFECTO DEL DISPOSITIVO: ${devices[index].name}');
                    print('NOMBRE: ${devices[index].name}');
                    print('MAC: ${devices[index].id}');
                    // TODO: ir a la configuración por defecto del dispositivo
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DeviceScreen(device: devices[index])));

//                    notify();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              alignment: Alignment.centerRight,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                /*Text(
                  'Look for devices',
                  style: TextStyle(color: Colors.black54),
                ),
                */
                StreamBuilder<bool>(
                    stream: FlutterBlue.instance.isScanning,
                    initialData: false,
                    builder: (c, snapshot) {
                      if (snapshot.data!) {
                        return Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            'Stop searching',
                            style: TextStyle(color: Colors.black54),
                          ),
                          IconButton(
                            icon: const Icon(Icons.stop),
                            iconSize: 50,
                            color: Colors.red,
                            onPressed: () {
                              FlutterBlue.instance.stopScan();
                            },
                          ),
                          /* FloatingActionButton(
                            onPressed: () => FlutterBlue.instance.stopScan(),
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.stop),
                          )*/
                        ]);
                      } else {
                        return Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            'Look for devices',
                            style: TextStyle(color: Colors.black54),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            iconSize: 50,
                            color: Colors.blue,
                            onPressed: () {
                              _startBluetoothScan();
                            },
                          ),
                          /*FloatingActionButton(
                              child: const Icon(Icons.search),
                              onPressed: () => _startBluetoothScan())*/
                        ]);
                        // FlutterBlue.instance.startScan(timeout: const Duration(seconds: 4)));
                      }
                    })
              ]))),

/*              IconButton(
                icon: Icon(Icons.search_rounded),
                iconSize: 30,
                color: Colors.black54,
                onPressed: () {
                  _startBluetoothScan();
                },
              ),
              */

      body: Column(
        children: [
          Expanded(
            child: _buildDeviceList(
                'Connected Devices',
                Icon(
                  Icons.bluetooth_connected,
                  size: 30,
                  color: Colors.blue,
                ),
                connectedDevices),
          ),
          Expanded(
            child: _buildDeviceList(
                'Discovered Devices',
                Icon(
                  Icons.bluetooth_disabled,
                  size: 30,
                  color: Colors.blue,
                ),
                discoveredDevices),
          ),
        ],
      ),
    );
  }
}
