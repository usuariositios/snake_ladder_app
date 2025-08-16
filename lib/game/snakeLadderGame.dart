import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/components/Ficha.dart';
import 'package:flutter/material.dart';
import 'package:snake_ladder_app/controllers/boardScreenController.dart';


class Snakeladdergame extends FlameGame {
  
  late Ficha ficha;  
  


  

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print("entro onload Snakeladdergame");
    final bController = Get.find<Boardscreencontroller>();
    

    ficha = Ficha(
      position: Vector2(bController.mapPosCeldas[0]!.dx, bController.mapPosCeldas[0]!.dy),
      size: Vector2(20, 40),
      sprite: await loadSprite('player_yellow.png'),
    );

  

    add(ficha);

    
  }
   @override
      Color backgroundColor() => Colors.transparent;
  
  void iniciaFichas(double posx, double posy){
    ficha.position = Vector2(posx,posy);
  }

  void moverFichaAPosicion(double posX,double posY) {
    Vector2 destino = Vector2(posX,posY);
    ficha.saltar(destino);
  }

  Future<void> saltarFichaAPosiciones(List<Offset> posDestinoList) async {
    await ficha.saltarVariasPosiciones(posDestinoList);
    print("termino saltar para mensaje");
    Get.find<Boardscreencontroller>().finalizarSaltos_action();
  }
  Future<void> saltarFichaPorEscalera(List<Offset> posDestinoList) async {
    await ficha.saltarVariasPosiciones(posDestinoList);
    print("termino escalera para mensaje");
    Get.find<Boardscreencontroller>().finalizaSaltosEscalera_action();
    
  }
  Future<void> bajarFichaPorSerpiente(Path pathDestino) async {
    await ficha.moverPorTrayectoria(pathDestino);
    print("termino serpiente para mensaje");
    Get.find<Boardscreencontroller>().finalizarBajarPorSerpiente_action();
    
  }



}