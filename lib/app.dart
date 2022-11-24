import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/timer.dart';
import 'package:flutter_timer/timer/view/timer_page.dart' as manual;
import 'package:libserialport/libserialport.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final availablePort = SerialPort.availablePorts;
    debugPrint('Available port: $availablePort');

    if (availablePort.isNotEmpty) {
      // final port1 = SerialPort('/dev/ttyUSB0')..openRead();
      final port1 = SerialPort(availablePort[0])..openRead();
      try {
        // Read Message
        final reader = SerialPortReader(port1, timeout: 5000);
        reader.stream.map((data) {
          return String.fromCharCodes(data);
        }).listen((data) {
          debugPrint('Read Data: $data');
          if (data.trim() == 'ST') {
            debugPrint('Initiating Timer!');
            manual.Actions.manualStartTimer();
          }
          if (data.trim() == 'IN') {
            debugPrint('Initiating Incrementer!');
            TimerBloc.duration = (TimerBloc.duration + 10) % 60;
            manual.Actions.manualResetTimer();
          }
        });
      } on SerialPortError catch (err, _) {
        debugPrint('$SerialPort.lastError');
        port1.close();
      }
    }

    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        colorScheme: const ColorScheme.light(
          secondary: Color.fromRGBO(72, 74, 126, 1),
        ),
      ),
      home: const TimerPage(),
    );
  }
}
