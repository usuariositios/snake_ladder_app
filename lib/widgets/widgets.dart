import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/material/dialog.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/menuGameController.dart';

class Widgets{
  void configuracionDialog(BuildContext context) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
              final mController = Get.put(MenuGameController());
              final theme = Theme.of(context);
              final defaultHoverColor = theme.colorScheme.primary.withOpacity(0.04);

                return AlertDialog(
                  title: Text('configuracion'.tr),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('tema'.tr),                
                        ElevatedButton(onPressed: () {
                            mController.toggleTheme();
                                  },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(mController.themeMode.value==ThemeMode.light?Icons.light_mode:Icons.dark_mode),
                          ],
                        )),
                        Text('idioma'.tr),
                        ElevatedButton(
                          onPressed: (){
                            mController.cambiarIdioma();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(mController.idioma.value),
                              Icon(Icons.language),
                            ],
                          )
                        ),
                        
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    SizedBox( width: double.infinity, // Makes the button take full width
                    child:TextButton(                      
                      style: TextButton.styleFrom(
                        backgroundColor: defaultHoverColor                        
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('aceptar'.tr),
                    ),
                    ),                    
                    
                  ],
                );
        
        
        
        

      
      
      
      },



    );
  }

  Widget ganadorPartidaDialog(String nombre) {//ganador del juego
              
              final defaultHoverColor = Get.theme.colorScheme.primary.withOpacity(0.04);

                return AlertDialog(
                  title: Text('ganador'.tr+"!!!"),
                  content: Text(nombre,style: TextStyle(fontSize: 30)),
                  actions: <Widget>[
                    SizedBox( width: double.infinity, // Makes the button take full width
                    child:TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: defaultHoverColor                        
                      ),
                      onPressed: () {
                        Get.toNamed('/', arguments: {
                        });
                      },
                      child: Text('aceptar'.tr),
                    ),
                    ),                    
                    
                  ],
                );
      
      
  }

}