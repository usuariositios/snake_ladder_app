import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/screens/boardScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter SVG Fondo',
      home: BoardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}