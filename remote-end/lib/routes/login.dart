import 'package:flutter/material.dart';
import 'package:my_app/data/shared.dart';
import 'package:my_app/logic/request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool notValidInput = false;
  final ipController = TextEditingController(text: '192.168.1.208');

  @override
  void initState() {
    setState(() {
      notValidInput = false;
    });
    super.initState();
  }

  void switchRoute() {
    Navigator.pushNamed(context, '/home');
  }

  void _validateAddress() async {
    String ip = ipController.text;

    if (ip.isEmpty || ip.contains(RegExp(r'[A-Za-z]'))) {
    } else {
      try {
        SharedData.ip = ipController.text;
        await initialRefresh().timeout(const Duration(seconds: 2));
        notValidInput = false; //Re-assurance
        switchRoute();
      } on Exception {
        SharedData.ip = "";
        setState(() {
          notValidInput = true;
        });
        // print('exception: $e');
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Client Side App'),
    );
    var availHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: availHeight,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Establish Connection',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'IP Address',
                  errorText: (notValidInput ? 'Invalid/Timeout' : null),
                ),
                controller: ipController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  _validateAddress();
                },
                child: const Text(
                  'Connect',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
