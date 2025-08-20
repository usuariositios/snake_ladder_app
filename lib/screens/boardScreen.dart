import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/boardScreenController.dart';
import 'package:snake_ladder_app/game/snakeLadderGame.dart';
import 'package:flame/game.dart';
import 'package:snake_ladder_app/widgets/mensaje_comic.dart';
import 'package:snake_ladder_app/widgets/rebotaImage.dart';

class BoardScreen extends StatelessWidget {
  final boardController = Get.put(Boardscreencontroller());
  final sgame = Snakeladdergame();
  
  
  

  
  

  @override
  Widget build(BuildContext context) {
    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;
    boardController.generarMapaPosiciones(screenAnc, screenAlt);//despues de dibujar el screen ya existe "context"
    
    Get.put(sgame);
    print("entro build BoardScreen");
    //Get.find<Snakeladdergame>().iniciaFichas(boardController.mapPosCeldas[1]!.dx, boardController.mapPosCeldas[1]!.dy) ;

    
    




    return Scaffold(
      body: Stack(
        children: [
          
          // Imagen SVG de fondo
          Positioned.fill(
            
            child: SvgPicture.asset(
              'assets/images/tabla_snake_ladder.svg', // Asegúrate de tener este archivo en assets
            
            fit: BoxFit.fill,//extiende la imagen svg al 100%

              
            
            ),
            
          ),
          
          // Mostrar las 100 casillas
          GameWidget(game: sgame),
          
              ...boardController.mapPosCeldas.entries.map((entry) {
                return Positioned(
                  left: entry.value.dx,
                  top: entry.value.dy,
                  child: Container(
                    width: boardController.celdaAnc,
                    height: boardController.celdaAlt,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black),
                      
                    ),
                    //child: Text('${entry.key}'),
                  ),
                );
              }).toList(),
          
          
          Obx(() {
            return Stack(
              children: boardController.mensajeComicList
                  .map((msg) => MensajeComic(
                      texto: msg,
                      offset: Offset(boardController.posMsjComic.value.dx,boardController.posMsjComic.value.dy),//-screenAlt*0.0749
                      ),
                      )
                  .toList(),
            );
          }),
          Positioned(
            top: screenAlt-screenAlt*0.11,
            //left: (screenAnc-100)/2,//al centro horizontal
            child://aqui el dice al centro y los jugadores
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // Alinea los widgets en la fila
                  children: <Widget>[
                    SizedBox(
                      width: screenAnc*0.40,
                      child:
                      Obx(() =>
                          Card(
                              color:Colors.white,//si no es numero su numero se coloca negro
                              elevation: 5, // Sombra del card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide(color: Colors.black, width: 1.0), // Borde
                              ),                        
                              child: 
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                    child:
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  
                                  
                                    RebotaImage(
                                        assetPath: 'assets/images/user.png',
                                        size: screenAnc *0.1,
                                        play: boardController.numFicha.value==0? true:false, // control desde afuera
                                        tag:'foto0'
                                      ),
                                    
                                    SizedBox(width: screenAnc*0.01,),                                                                    
                                     Text(
                                      'Jugador 1',
                                      style: TextStyle(fontSize: 20,                                         
                                        color: Colors.black),
                                    ),
                                  
                                  
                                ],
                              ),
                              ),              
                              
                            ),
                            )
                          ),
                      GestureDetector(
                        onTap: (){
                          boardController.lanzar_action();
                        },
                        child:
                        Obx(() =>
                        Stack(
                          alignment: Alignment.center, 
                          children: [
                          
                          Image.asset(
                            boardController.imagePathsList[boardController.indiceDice.value],
                            width: 100,
                            height: 100,
                            opacity: boardController.numTurnoDice>0?AlwaysStoppedAnimation(0.0):AlwaysStoppedAnimation(100),
                            
                          ),
                          
                          Image.asset(
                            boardController.imageDiceList[boardController.numTurnoDice.value],
                            width: 70,
                            height: 70,
                            opacity: boardController.numTurnoDice>0?AlwaysStoppedAnimation(100):AlwaysStoppedAnimation(0.0),
                          ),
                          

                        ],

                        )
                        
                        )
                      ),
                      SizedBox(
                      width: screenAnc*0.40,
                      child:
                      Obx(() =>
                          Card(
                              color: Colors.white,//si no es numero su numero se coloca negro
                              elevation: 2, // Sombra del card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide(color: Colors.black, width: 1.0), // Borde
                              ),                        
                              child: 
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                    child:
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  
                                  
                                    RebotaImage(
                                        assetPath: 'assets/images/user.png',
                                        size: screenAnc *0.1,
                                        play: boardController.numFicha.value==1? true:false, // control desde afuera
                                        tag:'foto1'
                                      ),
                                    SizedBox(width: screenAnc*0.01,),                                                                    
                                     Text(
                                      'Jugador 2',
                                      style: TextStyle(fontSize: 20,                                         
                                        color: Colors.black),
                                    ),
                                  
                                  
                                ],
                              ),
                              ),              
                              
                            ),
                            )
                          ),

            ]
        )

          ),
        

          
        ],
      ),
    );
  }
}