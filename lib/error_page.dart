import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ERROR'),
      ),
      body: const Center(
        child: Text(
          'CHECK YOU CONNECTION pls :c',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
