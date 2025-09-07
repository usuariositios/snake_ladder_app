import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';
import 'package:snake_ladder_app/widgets/selectorOpciones.dart';

class JugadoresScreen extends StatelessWidget {
  final mController = Get.put(MenuGameController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body:  Stack(
        children: [
          Positioned.fill(
            child: 
            Opacity(
              opacity: 0.5, // valor entre 0.0 (transparente) y 1.0 (opaco)
              child:SvgPicture.asset(
                'assets/images/tabla_snake_ladder.svg', // Asegúrate de tener este archivo en assets            
              fit: BoxFit.fill,//extiende la imagen svg al 100%
              
              ),
            ),            
            
          ),
          Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400), // 👈 limite para el scroll
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [            
            
            

            const SizedBox(height: 12),
            SelectorOpciones(
              opciones: [( 2,'2 Jugadores'),
                          ( 3,'3 Jugadores'),
                          ( 4,'4 Jugadores'),],
              onSeleccion: (valor) {
                mController.numJugadores.value = valor;
              },
              opcionInicial: 2,
            ),
            const SizedBox(height: 12),
                        ElevatedButton(
                              onPressed: () {
                                mController.irboardscreen_action();
                              },
                              child: const Text("Jugar"),
                        ),
          ],
        ),
      ),
    )
          ]
          )      
    );
  }
}