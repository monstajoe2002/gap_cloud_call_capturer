import 'package:flutter/material.dart';
import 'package:gap_cloud_call_capturer/phone_state_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PhoneStateListener _phoneListener = PhoneStateListener();
  @override
  void dispose() {
    _phoneListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Capturer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Call Capturer'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Center(
            child: AnimatedBuilder(
                animation: _phoneListener,
                builder: (context, child) {
                  return Text(
                    'Call Duration: ${_phoneListener.callDuration}',
                    style: const TextStyle(fontSize: 24),
                  );
                }),
          )),
    );
  }
}
