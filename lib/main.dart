import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/datasources/remote_datasource.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
        child: Text('World'),
        ),
      ),
    );
  }
}
