import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';
import 'package:snake_ladder_app/screens/boardScreen.dart';
import 'package:snake_ladder_app/screens/menuScreen.dart';
import 'package:snake_ladder_app/screens/jugadoresScreen.dart';
import 'package:snake_ladder_app/screens/nombresScreen.dart';
import 'package:snake_ladder_app/util/AppTranslations';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTranslations.load();//cargar traducciones antes de correr la app
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // pantalla completa

  runApp(MyApp());//para que tenga un context);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final mController = Get.put(MenuGameController(),permanent: true);
  
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
            GetPage(name: '/', page: () => MenuScreen()),
            GetPage(name: '/board_screen', page: () => BoardScreen()), // tu pantalla del juego      
            GetPage(name: '/modos_screen', page: () => JugadoresScreen()), // tu pantalla del juego      
            GetPage(name: '/nombres_screen', page: () => NombresScreen()), // tu pantalla del juego      
          ],
            translations: AppTranslations(),
            locale: Get.deviceLocale,//idioma inicial
            fallbackLocale: Locale('en','US'),
            title: 'Snakes and Ladders Challenges',
            theme: ThemeData.light(),   // Tema claro
            darkTheme: ThemeData.dark(),// Tema oscuro
            home: MenuScreen(),
            themeMode: mController.themeMode.value, // Se controla con GetX
      )
  );
  }
}