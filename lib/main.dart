import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_1/core/routes/my_router.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router, // here is defining go router
      
    );
  }
}
