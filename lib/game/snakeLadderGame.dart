import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/components/Ficha.dart';
import 'package:flutter/material.dart';
import 'package:snake_ladder_app/controllers/boardScreenController.dart';


class Snakeladdergame extends FlameGame {// with WidgetsBindingObserver para reaccionar a paused o resumed del smartphone
  
  //late Ficha ficha;//ficha individual
  
  late List<Ficha> fichaList;//array de fichas
  List<String> imageFichasList = [
    'player_yellow.png',//colocar valor nominal indice 0
    'player_blue.png',//desde indice 1
    'player_red.png',
    'player_green.png',    
  ]; 


  /*@override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    if (state == AppLifecycleState.paused) {
      // Evitar que se pause
      resumeEngine();
    } else if (state == AppLifecycleState.resumed) {
      resumeEngine();
    }
  }*/

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print("entro onload Snakeladdergame");
    final bController = Get.find<Boardscreencontroller>();//con bController enviar numJugadores al juego Flame
    bController.loadingImage.value = true;//para esperar carga
    /*fichaList =  [Ficha(
                  position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),//posicion inicial
                  size: Vector2(20, 40),
                  sprite: await loadSprite('player_yellow.png'),
                ),
                Ficha(
                  position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
                  size: Vector2(20, 40),
                  sprite: await loadSprite('player_blue.png'),                 
                ),
                Ficha(
                  position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
                  size: Vector2(20, 40),
                  sprite: await loadSprite('player_red.png'),                                    
                ),
                Ficha(
                  position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
                  size: Vector2(20, 40),
                  sprite: await loadSprite('player_green.png'),                
                )];*/
      fichaList  = await cargarFichas(bController); //esperar a que cargue la lista con imagenes

      iniciarFichas(bController);//no cargo aun las imagenes hay que esperar asigna nombres
      bController.iniciarNombresFichas();//cuando el juego flame ya esta en memoria
      bController.loadingImage.value = false;//despues de await para imagenes
    /*ficha = Ficha(
      position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
      size: Vector2(20, 40),
      sprite: await loadSprite('player_yellow.png'),
    );*/

  

    //add(ficha);
    addAll(fichaList);

    
  }
  


  Future<List<Ficha>> cargarFichas(Boardscreencontroller bController) async {//por la carga de imagenes
  print('nro fichas a tomar ${bController.numTotalFichas}');
  

List<Ficha> tempList =[];
  for (int i = 0; i < bController.numTotalFichas; i++) {    
    
    Sprite sprite = await Sprite.load(imageFichasList[i]);//esperar a que cargue image
    tempList.add(Ficha(position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
                           size: Vector2(20, 40),
                           sprite: sprite));
  }

  return tempList;
  }

  void iniciarFichas(Boardscreencontroller bController){//iniciar objetos de flame en flame
    for(int i=0;i<fichaList.length;i++){//asignar nombres por defecto a las fichas      
      fichaList[i].nombre = bController.nombresList[i];//'Jugador${i+1}';
      fichaList[i].pathImage = imageFichasList[i];
      print(fichaList[i].pathImage);
    }
    
    
  }
  
   @override
      Color backgroundColor() => Colors.transparent;
  
  /*void iniciaFichas(double posx, double posy){
    ficha.position = Vector2(posx,posy);
  }

  void moverFichaAPosicion(double posX,double posY) {
    Vector2 destino = Vector2(posX,posY);
    ficha.saltar(destino);
  }*/

  Future<void> saltarFichaAPosiciones(List<Offset> posDestinoList,int numFicha) async {
    
    //ficha = fichaList[numFicha];//se asigna el numero de ficha para que salte
    await fichaList[numFicha].saltarVariasPosiciones(posDestinoList);
    print("termino saltar para mensaje");
    Get.find<Boardscreencontroller>().finalizarSaltos_action();
  }
  Future<void> saltarFichaPorEscalera(List<Offset> posDestinoList,int numFicha) async {
    //ficha = fichaList[numFicha];//se asigna el numero de ficha para que salte
    await fichaList[numFicha].saltarVariasPosiciones(posDestinoList,vSubir:0.2,vBajar:0.1);
    print("termino escalera para mensaje");
    Get.find<Boardscreencontroller>().finalizaSaltosEscalera_action();
    
  }
  Future<void> bajarFichaPorSerpiente(Path pathDestino,int numFicha) async {
    //ficha = fichaList[numFicha];//se asigna el numero de ficha para que baje
    await fichaList[numFicha].moverPorTrayectoria(pathDestino);
    print("termino serpiente para mensaje");
    Get.find<Boardscreencontroller>().finalizarBajarPorSerpiente_action();
    
  }



}