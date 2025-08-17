import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/screens/boardScreen.dart';
import 'package:snake_ladder_app/screens/menuScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // pantalla completa
  runApp(GetMaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  getPages: [
      GetPage(name: '/', page: () => MenuScreen()),
      GetPage(name: '/board_screen', page: () => BoardScreen()), // tu pantalla del juego      
    ],
  ));//para que tenga un context);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter SVG Fondo',
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}