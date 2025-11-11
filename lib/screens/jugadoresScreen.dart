import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';
import 'package:snake_ladder_app/widgets/galeriaImage.dart';
import 'package:snake_ladder_app/widgets/selectorOpciones.dart';

class JugadoresScreen extends StatelessWidget {
  final mController = Get.put(MenuGameController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    
    mController.numTabla.value = 0;//resetar el valor num tabla por que se vuelve a construir el widget
    return Scaffold(
      body:  Stack(
        children: [
          Positioned.fill(
            child: 
            Opacity(//la parte de atras
              opacity: 0.5, // valor entre 0.0 (transparente) y 1.0 (opaco)
              child:SvgPicture.asset(
                'assets/images/tabla_snake_ladder.svg', // Asegúrate de tener este archivo en assets            
              fit: BoxFit.fill,//extiende la imagen svg al 100%
              
              ),
            ),            
            
          ),
          Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: 
      //Column(children: [
      
      Stack(
        children: [
          
      Container(
        
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            GaleriaImage(
              onSiguiente_action: (valor) {                
                mController.numTabla.value = valor;
              },
              onAnterior_action: (valor) {                
                mController.numTabla.value = valor;
              },
            ),          
            const SizedBox(height: 5),
            SelectorOpciones(
              opciones: [( 2,'2 '+'jugadores'.tr),
                          ( 3,'3 '+'jugadores'.tr),
                          ( 4,'4 '+'jugadores'.tr),],
              onSeleccion: (valor) {
                mController.numJugadores.value = valor;
              },
              opcionInicial: 2,
            ),
            const SizedBox(height: 5),
                        ElevatedButton(
                              onPressed: () {
                                mController.irboardscreen_action();
                              },
                              child: Text('jugar'.tr),
                        ),
          ],
        ),
      ),      
           Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: (){                
                Get.toNamed('/', arguments: {//a la pantalla inicial      
                });                
              }, // o Navigator.pop(context)
            ),
        ),
        
        
        
      ]
      )
      //],)

    )
          ]
          )      
    );
  }
}