import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';
import 'package:snake_ladder_app/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';





class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}


class _MenuScreenState extends State<MenuScreen> {
  //late AppLocalizations t;
  final mController = Get.put(MenuGameController(),permanent: true);

  


  Widgets widgets = Widgets();//widgets externos
  late bool isDark;

  @override
  Widget build(BuildContext context) {
    //t = AppLocalizations.of(context)!;    
    //isDark = themeNotifier.value == ThemeMode.dark;
    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;

    mController.cargarJugadores();//nombres de jugadores
  

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A2980),
              Color(0xFF26D0CE),
            ],
          ),
        ),
        child: 
      Stack(
          children: [
              Positioned(
              top: 30,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.settings, size: 32),
                color: Colors.white,
                onPressed: () {
                  widgets.configuracionDialog(context);
                },
              ),
            ),
        Center(
              child:
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo del juego (centrado)
            ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child:
            Image.asset(
                    'assets/images/snake_ladder_icon.png',
                    width: screenAnc *0.3,
                    height: screenAnc *0.3,

                    
                  ),),
            
           
                  SizedBox(height: screenAlt*0.1,),
            ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(screenAnc*0.7,screenAlt*0.05),                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),),
                      onPressed: () {                        
                        mController.irmodosscreen_action();
                      },
                      child: Text(
                        'empezar'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenAlt*0.02,),
            ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(screenAnc*0.7,screenAlt*0.05),                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),),
                      onPressed: () {
                        mController.irnombresscreen_action();
                        //controller.ir_jugadorscreen();
                        // Navegar a pantalla de modos de juego
                      },
                      child: Text(
                        'jugadores'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      ),                    
                    ),
            // Botones principales (centrados verticalmente)
            

            
          ],
        ),
        )
          ])
      
      ),
    );
  }

  /*void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return ValueListenableBuilder<Locale>(
        valueListenable: localeNotifier,
        builder: (_, __, ___) {
          final t = AppLocalizations.of(context);

        return AlertDialog(
          title: Text(t!.translate('configuracion')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(t.translate('tema')),                
                ElevatedButton(onPressed: () {
                          setState(() {
                            themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
                              
                          });},
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  ],
                 )),
                Text(t.translate('idioma')),
                ElevatedButton(
                  onPressed: (){
                    localeNotifier.value =  localeNotifier.value.languageCode == 'es'? const Locale('en'): const Locale('es');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(localeNotifier.value.languageCode),
                      Icon(Icons.language),
                    ],
                  )
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.translate('cerrar')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        }
      );

      },
    );
  }*/
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla de Juego')),
      body: const Center(child: Text('Contenido del juego')),
    );
  }
}