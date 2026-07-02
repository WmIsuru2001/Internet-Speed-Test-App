import 'package:flutter/material.dart';
import 'package:internet_speed_test_app/speed_test_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SpeedTestUi());
  }
}
