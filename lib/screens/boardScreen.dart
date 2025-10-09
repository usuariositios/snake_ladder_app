import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/boardScreenController.dart';
import 'package:snake_ladder_app/game/snakeLadderGame.dart';
import 'package:flame/game.dart';
import 'package:snake_ladder_app/service/gameService.dart';
import 'package:snake_ladder_app/widgets/mensaje_comic.dart';
import 'package:snake_ladder_app/widgets/rebotaImage.dart';


class BoardScreen extends StatelessWidget {
  final boardController = Get.put(Boardscreencontroller(),permanent: true);
  final sgame = Snakeladdergame();
  
  
  

  
  

  @override
  Widget build(BuildContext context) {
    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;
    boardController.generarMapaPosiciones(screenAnc, screenAlt);//despues de dibujar el screen ya existe "context"
    
    Get.put(sgame);
    print("entro build BoardScreen");
    //Get.find<Snakeladdergame>().iniciaFichas(boardController.mapPosCeldas[1]!.dx, boardController.mapPosCeldas[1]!.dy) ;
    boardController.sgame = sgame;//asignamos al controlador
    //boardController.iniciarNombresFichas();
    //aqui setear los valores al controlador board
    
    try {
      final args = Get.arguments as Map<String, dynamic>;
    
    boardController.numTotalFichas = args['numJugadores']; //entrega de variables enviadas el widget y guardar al controlador
    
    } catch (e) {//puede llegar nulo al screen
      e.printError();
      boardController.numTotalFichas=2;
    }
    try{
      final args = Get.arguments as Map<String, dynamic>;
      
      boardController.nombresList = args['nombresList'];//tratar de obtener los nombres jugadores
    }catch(e){//puede llegar nulo al screen
      e.printError();
      boardController.nombresList=[//nombres de jugadores
    'Jugador 1',
    'Jugador 2',
    'Jugador 3',
    'Jugador 4'
        ];

      }

    try {
      final args = Get.arguments as Map<String, dynamic>;
    
    boardController.numTabla = args['numTabla']; //entrega de variables enviadas el widget y guardar al controlador
    boardController.cargarPosiciones();//funcion asincrona para cargar posiciones despues de cargar el numero de tabla (la variable ya esta en el controlador)
    } catch (e) {//puede llegar nulo al screen
      e.printError();
      boardController.numTabla=0;
      boardController.cargarPosiciones();
    }

    try {
      final args = Get.arguments as Map<String, dynamic>;
    
    boardController.idioma.value = args['idioma']; //entrega de variables enviadas el widget y guardar al controlador
    boardController.cargarPreguntas(boardController.idioma.value);
    } catch (e) {//puede llegar nulo al screen
      e.printError();
      boardController.idioma.value='en';
      boardController.cargarPreguntas(boardController.idioma.value);      
    }



    //precargar las imagenes del dice
    
    for (var path in boardController.imagePathsList) {
        precacheImage(AssetImage(path), context);
    }
    


    
    
    




    return Scaffold(
      body: Stack(
        children: [
          
          
          // Imagen SVG de fondo
          Positioned.fill(
            
            child: SvgPicture.asset(
              'assets/images/tabla_snake_ladder${boardController.numTabla}.svg', // Asegúrate de tener este archivo en assets
            
            fit: BoxFit.fill,//extiende la imagen svg al 100%

              
            
            ),
            
          ),
          
          
          // Mostrar las 100 casillas
          GameWidget(game: sgame,), //overlayBuilderMap: null,//para que se mantenga persistente
          
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
          //colocar el boton de menu a la esquina derecha
          Positioned(
            right: 0,
            top: screenAlt*0.112,
            child:
            Opacity(opacity: 0.5,
            child: 
            IconButton(icon: Icon(Icons.pause_circle_outline),
            iconSize: screenAlt*0.05,
            onPressed: (){
              boardController.mostrarOpciones_action();
            })
            )
          ),
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
                              
                              elevation: 1, // Sombra del card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide( width: 1.5), // Borde
                              ),                        
                              child: 
                              Padding(
                                padding: EdgeInsets.only(left: screenAnc *0.01,
                                          right: screenAnc *0.01,
                                          top: screenAnc *0.05,
                                          bottom: screenAnc *0.05,),
                                    child:
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  
                                  boardController.loadingImage.value == false?
                                    RebotaImage(
                                        assetPath: 'assets/images/${boardController.pathFicha0.value}',
                                        size: screenAnc *0.1,
                                        play: (boardController.numFicha.value==0 || boardController.numFicha.value==2)? true:false, // control desde afuera
                                        tag:'foto0'
                                      ):CircularProgressIndicator(),
                                    
                                    SizedBox(width: screenAnc*0.01,),                                                                    
                                     Expanded(                                                                    
                                            child:Text(
                                                boardController.nombreFicha0.value,
                                                style: TextStyle(fontSize: 20,                                         
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis, // ...
                                    ),
                                    ),
                                  
                                  
                                ],
                              ),
                              ),              
                              
                            ),
                            )
                          ),
                      GestureDetector(
                        onTap: (){
                          if(boardController.enableLanzar.value ==true){
                            boardController.lanzar_action();
                          }                          
                        },
                        child:
                        Obx(() =>
                        Stack(
                          alignment: Alignment.center, 
                          children: [
                          
                          Positioned(top:0,
                          child:                             
                            Container(
                            width: screenAnc*0.2,
                            height: screenAlt*0.14,
                            color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            boardController.imagePathsList[boardController.indiceDice.value],
                            width: screenAnc *0.2,
                            height: screenAnc *0.2,
                            opacity: boardController.numTurnoDice>0?AlwaysStoppedAnimation(0.0):AlwaysStoppedAnimation(100),
                            
                          ),
                          
                          Image.asset(
                            boardController.imageDiceList[boardController.numTurnoDice.value],
                            width: screenAnc *0.14,
                            height: screenAnc *0.14,
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
                              elevation: 0, // Sombra del card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide(width: 1.5), // Borde
                              ),                        
                              child: 
                              
                              Padding(
                                padding: EdgeInsets.only(left: screenAnc *0.01,
                                          right: screenAnc *0.01,
                                          top: screenAnc *0.05,
                                          bottom: screenAnc *0.05,),
                                    child:
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                            boardController.loadingImage.value == false?
                                            RebotaImage(
                                                assetPath: 'assets/images/${boardController.pathFicha1.value}',
                                                size: screenAnc *0.1,
                                                play: boardController.numFicha.value==1 || boardController.numFicha.value==3? true:false, // control desde afuera
                                                tag:'foto1'
                                              ):CircularProgressIndicator(),

                                            SizedBox(width: screenAnc*0.01,),
                                            Expanded(                                                                    
                                            child:Text(
                                                boardController.nombreFicha1.value,
                                                style: TextStyle(fontSize: 20,                                         
                                                  ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis, // ...
                                            ),),
                                          
                                          
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