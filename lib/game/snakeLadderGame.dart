import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/components/Ficha.dart';
import 'package:flutter/material.dart';
import 'package:snake_ladder_app/controllers/boardScreenController.dart';


class Snakeladdergame extends FlameGame {
  
  //late Ficha ficha;//ficha individual
  
  late List<Ficha> fichaList;//array de fichas
  


  

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print("entro onload Snakeladdergame");
    final bController = Get.find<Boardscreencontroller>();
    fichaList = [Ficha(
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
                )];
      iniciarFichas();
      Get.find<Boardscreencontroller>().iniciarNombresFichas();//cuando el juego flame ya esta en memoria

    /*ficha = Ficha(
      position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
      size: Vector2(20, 40),
      sprite: await loadSprite('player_yellow.png'),
    );*/

  

    //add(ficha);
    addAll(fichaList);

    
  }
  void iniciarFichas(){//iniciar objetos de flame en flame
    for(int i=0;i<fichaList.length;i++){//asignar nombres por defecto a las fichas      
      fichaList[i].nombre = 'Jugador${i+1}';
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
    await fichaList[numFicha].saltarVariasPosiciones(posDestinoList);
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