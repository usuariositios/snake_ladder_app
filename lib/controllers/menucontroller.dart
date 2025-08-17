import 'package:get/get.dart';


class menuController extends GetxController {
  var idioma = 'es'.obs; // 'es' o 'en'
  var nombreJugador = ''.obs;
  var numeroJugadores = 2.obs;
  List<String> jugadoresList=[
    'jugador 1',
    'jugador 2'
  ];//lista de jugadores


  

  void cambiarIdioma_action(String nuevo) {
    idioma.value = nuevo;
  }

  

  void irboardscreen_action() {    
    
    // Ir a la pantalla principal del juego
    Get.toNamed('/board_screen', arguments: {
      //'idioma': idioma.value,
    });
  }
  

}