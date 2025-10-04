import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';


class NombresScreen extends StatelessWidget {
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
      child: 
      Stack(
        children: [

      Container(
        constraints: const BoxConstraints(maxHeight: 400), // 👈 limite para el scroll
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [            
            
            

            const SizedBox(height: 12),
            Expanded(
              child:
            Obx(() {
                return ListView.builder(
                  itemCount: mController.inputsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: mController.inputsList[index],
                        decoration: InputDecoration(
                          labelText: "jugador".tr + "${index + 1}",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                );
              })
            ),
            const SizedBox(height: 12),
                        ElevatedButton(
                              onPressed: () {
                                mController.guardarNombres_action();
                              },
                              child: Text("aceptar".tr),
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
        )
      ]
      )
    )
          ]
          )      
    );
  }
}