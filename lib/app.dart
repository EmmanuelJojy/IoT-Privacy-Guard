import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/timer.dart';

import 'package:libserialport/libserialport.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Confirming Port
    List<String> availablePort = SerialPort.availablePorts;
    print('Available port: $availablePort');
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