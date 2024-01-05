// ignore_for_file: file_names, non_constant_identifier_names, unused_element, avoid_print, unrelated_type_equality_checks, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

//Pantalla del BLUETOOTH
class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<DeviceScreen> {
  Color mycolor = Colors.lightBlue;
  Color confirmacion = Colors.lightBlue;
  String colorPicked = "";
  //String CCCD_ID_UUID = "00002902-0000-1000-8000-00805f9b34fb";
  String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  String DESCRIPTOR_UUID = "00002902-0000-1000-8000-00805f9b34fb";
  late BluetoothCharacteristic targetCharacteristic;
  late var descriptors;
  String connectionText = "";
  String distancia_txt = "";
  int deviceStatus = 1; //1-connected 0-diconnected

  void changeColor(Color color) => setState(() {
        mycolor = color;
        colorPicked = '${mycolor.red},${mycolor.green},${mycolor.blue}';
        print(colorPicked);
      });

  List<int> _getColorPicked() {
    return [mycolor.red, mycolor.green, mycolor.blue];
  }

  _write() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    //for (BluetoothService service in services) {
    for (var service in services) {
      // do something with service
      if (service.uuid.toString() == SERVICE_UUID) {
        //for (BluetoothCharacteristic characteristic in service.characteristics) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            targetCharacteristic = characteristic;

            //CAMBIAR EL COLOR DEL LED
            print(colorPicked);
            List<int> bytes = utf8.encode(colorPicked);
            targetCharacteristic.write(bytes);

            setState(() {
              confirmacion = mycolor;
            });

            if (targetCharacteristic.properties.notify) {
              //DESCRIPTOR
              descriptors = targetCharacteristic.descriptors;
              if (descriptors.toString() == DESCRIPTOR_UUID) {
                Future<List<int>> descriptorValue = descriptors[0].read();
                print('Descriptor value : $descriptorValue');
              }

              await Future.delayed(const Duration(seconds: 5));

              // END-DESCRIPTOR

              //await targetCharacteristic.setNotifyValue(true);
              targetCharacteristic.setNotifyValue(true);
              //var list = targetCharacteristic.value.listen((event) {
              targetCharacteristic.value.listen((event) {
                if (event.isNotEmpty) {
                  setState(() {
                    distancia_txt = utf8.decode(event);
                    //if (distancia_txt == "") distancia_txt = ">40";
                    print('Distancia: $distancia_txt');
                  });
                }
              });
              //list.cancel();
              await Future.delayed(const Duration(seconds: 3));
            }
          }
        }
      }
    }
  }

/*
  notify() async {
    if (targetCharacteristic.properties.notify) {
      //Descriptor
      var descriptors = targetCharacteristic.descriptors;

      for (final BluetoothDescriptor d in descriptors) {
        Future<List<int>> descriptorValue = d.read();
        print('Descriptor value : $descriptorValue');
      }
      //     await targetCharacteristic.setNotifyValue(true);
      targetCharacteristic.value.listen((event) {
        setState(() {
          if (event.isNotEmpty) {
            distancia_txt = utf8.decode(event);
          }
          if (distancia_txt == "") distancia_txt = ">40";
        });
        print('Distancia: $distancia_txt cm del sensor');
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    //   final providerDevice = Provider.of<DeviceProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.device.name),
          actions: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: widget.device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) {
                String text;

                switch (snapshot.data) {
                  case BluetoothDeviceState.connected:
                    text = 'DISCONNECT';
                    deviceStatus = 1;
                    break;
                  case BluetoothDeviceState.disconnected:
                    text = 'CONNECT';
                    deviceStatus = 0;
                    break;
                  default:
                    text = snapshot.data.toString().substring(21).toUpperCase();
                    break;
                }
                return TextButton(
                    onPressed: () {
                      switch (snapshot.data) {
                        case BluetoothDeviceState.connected:
                          setState(() {
                            deviceStatus = 0;
                          });

                          widget.device.disconnect();
                          // TODO: Actualizar la lista de conectados y descubiertos cuando se desconecta manualmente un dispositivo
                          //connectedDevices.remove(widget.device);
                          //discoveredDevices.add(widget.device);
                          break;
                        case BluetoothDeviceState.disconnected:
                          setState(() {
                            deviceStatus = 1;
                          });

                          widget.device.connect();
                          // TODO: Actualizar la lista de conectados y descubiertos cuando se desconecta manualmente un dispositivo
                          //connectedDevices.add(widget.device);
                          //discoveredDevices.remove(widget.device);
                          break;
                        default:
                          break;
                      }
                    },
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .labelLarge
                          ?.copyWith(color: Colors.blue),
                    ));
              },
            ),
            /*         StreamBuilder<List<BluetoothService>>(
            stream: widget.device.services,
            initialData: [],
            builder: (c, snapshot) {
              return _myService(snapshot.data);
            },
          ),
          */
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                if (deviceStatus == 1) ...[
                  const Icon(Icons.bluetooth_connected),
                  const Text('Device is connected')
                ] else ...[
                  const Icon(Icons.bluetooth_disabled),
                  const Text('Device is disconnected'),
                ],
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Text('${widget.device.id}'),
              ), //Container
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: useWhiteForeground(mycolor) //foreground
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                    backgroundColor: mycolor, //foreground
                  ),
                  onPressed: () {
                    //                 providerDevice.cambiarColor(mycolor);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(30.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                  pickerColor: mycolor,
                                  onColorChanged: changeColor),
                            ),
                            actions: [
                              FloatingActionButton(
                                onPressed: () => {
                                  Navigator.pop(context, true),
                                  _write(),
                                },
                                child: const Text("OK"),
                              ),
                              /* FloatingActionButton(
                            elevation: 0.0,
                            child: const Icon(Icons.check),
                            backgroundColor: confirmacion,
                            onPressed: () => _writeBLUE()),*/
                            ],
                          );
                        });
                  },
                  child: const Text("Color"),
                ),
              ), //Container
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'RGB: ${mycolor.red}, ${mycolor.green}, ${mycolor.blue}',
                  )), //Container
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: (distancia_txt != "")
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Objeto a $distancia_txt cm del sensor',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(''), //Container
                    ),
            ),
          ],
        ));
  }

/*
  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () => c.write(notify()),
                    onNotificationPressed: () =>
                        c.setNotifyValue(!c.isNotifying),
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(notify()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle:
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotificationPressed;

  const CharacteristicTile(
      {Key? key,
      required this.characteristic,
      required this.descriptorTiles,
      required this.onReadPressed,
      required this.onWritePressed,
      required this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;

  const DescriptorTile(
      {Key? key,
      required this.descriptor,
      required this.onReadPressed,
      required this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.titleMedium,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.titleMedium?.color,
        ),
      ),
    );
  }
  */
}
