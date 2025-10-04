import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/widgets/widgets.dart';


class MenuGameController extends GetxController {
  var idioma = 'es'.obs; // 'es' o 'en'
  //var locale = const Locale('en', 'US').obs;
  var locale = Get.deviceLocale ?? const Locale('en', 'US');

  var nombreJugador = ''.obs;
  Rx<int> numJugadores = 2.obs;
  List<String> jugadoresList=[//nombres de jugadores
    'Jugador 1',
    'Jugador 2',
    'Jugador 3',
    'Jugador 4'
  ];//lista de jugadores
  var inputsList = <TextEditingController>[].obs;
  Rx<int> numTabla = 0.obs;
  var themeMode = ThemeMode.light.obs;
  
  @override
  void onInit() {
    super.onInit();
    cargarInputs();//inputs de los nombres de jugadores
    print('entro oninit MenuGameController');//ingresa una sola vez
    var locale = Get.deviceLocale;
    print(locale!.languageCode);
    idioma.value = locale!.languageCode;
    
  }
  
  void cargarInputs(){
    // Ejemplo: inicializamos con 3 inputs vacíos
    for (int i = 0; i < jugadoresList.length; i++) {
      TextEditingController t = TextEditingController();
      t.text = jugadoresList[i];
      inputsList.add(t);
    }

  }

  List<(int,String)> opcionesList = [
      ( 2,'2 Jugadores'),
      ( 3,'3 Jugadores'),
      ( 4,'4 Jugadores'),
    ];

  
  

  void cambiarIdioma_action(String nuevo) {
    idioma.value = nuevo;
  }

  

  void irboardscreen_action() {    
    
    print('jugadores a enviar $numJugadores');
    print('numTabla a enviar ${numTabla.value}' );
    Get.toNamed('/board_screen', arguments: {
      'numJugadores': numJugadores.value,
      'nombresList': jugadoresList,
      'numTabla':numTabla.value
    });
  }

  void irmodosscreen_action() {
    
    Get.toNamed('/modos_screen', arguments: {      
    });
  }

  void irnombresscreen_action() {
    
    Get.toNamed('/nombres_screen', arguments: {      
    });
  }

  void guardarNombres_action(){
    jugadoresList =  inputsList.map((c) => c.text).toList();//se actualiza la lista de nombres
    /*for(int i = 0;i<jugadoresList.length;i++){
      print(jugadoresList[i]);
    }*/
    Get.toNamed('/', arguments: {//a la pantalla inicial      
    });
  }

  void cambiarIdioma() {
    switch (idioma.value) {
      case 'es':
        idioma.value = 'en';
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'en':
        idioma.value = 'es';
        Get.updateLocale(Locale('es', 'ES'));
        break;
      default:
    }    
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }
  
  

  

}