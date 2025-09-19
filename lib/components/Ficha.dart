import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:audioplayers/audioplayers.dart';



class Ficha extends SpriteComponent {
  int nroCeldaActual=0;//celda actual en 0 para que salte a 1
  String nombre="";//nombre de jugador
  String pathImage = "";//colocar luego que se cargue el array
  int factorSize = 0;//porcentaje para el tamaño de la ficha
  double tAcum = 0;
  final AudioPlayer audioPlayer = AudioPlayer();

  Ficha({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,//se guarda la imagen en memoria pero no el path        
  }) : super(position: position, size: size, sprite: sprite);
  





void saltar(Vector2 destino) {//aqui recibir el array de 
    final double alturaSalto = -100; // altura negativa = hacia arriba

    /*final moveUp = MoveByEffect(
      Vector2(0, alturaSalto),
      EffectController(duration: 1, reverseDuration: 0),
    );*/
    final moveUp = MoveEffect.by(
      Vector2(0, -50), // Move 50 pixels up
      EffectController(duration: 0.2), // Quick jump up
    );

    final moveDown = MoveEffect.by(
      Vector2(50, 50), // Move 50 pixels down
      EffectController(duration: 0.2), // Quick jump down
    );

    final moveHoriz = MoveEffect.to(
      Vector2(destino.x, destino.y+50),//para bajar la ficha
      EffectController(duration: 0.3),
    );

    /*
    final moveDown = MoveByEffect(
      Vector2(0, 0),
      EffectController(duration: 1, reverseDuration: 0),
    );*/

    //final salto = SequenceEffect([moveUp, moveHoriz, moveDown]);
    //final salto = SequenceEffect([moveUp,moveHoriz]); //moveHoriz,
    


    //add(salto);
    addAll([moveUp,moveHoriz]);

    
  }
  

  Future<void> saltarVariasPosiciones(List<Offset> destinoLists,{double vSubir=0.3, double vBajar=0.4}) async {//aqui recibir el array de 
    final double alturaSalto = -100; // altura negativa = hacia arriba

    /*final moveUp = MoveByEffect(
      Vector2(0, alturaSalto),
      EffectController(duration: 1, reverseDuration: 0),
    );*/
    

    
    MoveEffect bajarFicha;

    for (final destino in destinoLists) {
      final AudioPlayer audioPlayer = AudioPlayer();//para que se reproduzca cada sonido de manera independiente
      
      bajarFicha = MoveEffect.to(
            Vector2(destino.dx, destino.dy+80),//para bajar la ficha
            EffectController(duration: vBajar),
            onComplete: () async {
              await audioPlayer.play(AssetSource('sounds/step_land.mp3'));//por el sonido en una variable                            
            }
          );
          
      

      final efectos = [
          MoveEffect.by(
            Vector2(0, -80), // Move 50 pixels up
            EffectController(duration: vSubir), // Quick jump up
          ),
          bajarFicha
      ];

      final futures = efectos.map((e) => e.completed).toList();

      addAll(efectos);
      await Future.wait(futures);//esperar a que los efectos terminen
      
      
      
  }
  

    /*
    final moveDown = MoveByEffect(
      Vector2(0, 0),
      EffectController(duration: 1, reverseDuration: 0),
    );*/

    //final salto = SequenceEffect([moveUp, moveHoriz, moveDown]);
    //final salto = SequenceEffect([moveUp,moveHoriz]); //moveHoriz,
    


    //add(salto);
    

    
  }

  Future<void> moverPorTrayectoria(Path path) async {//mover a travez del path
    await audioPlayer.play(AssetSource('sounds/serpiente.mp3'));
    final efecto = MoveAlongPathEffect(
      path,
      EffectController(duration: 2.0, curve: Curves.easeInOut), // duración y curva
      absolute: true, // usa coordenadas absolutas
    );
  add(efecto);
  
  await efecto.completed;//esperar a que los efectos terminen
}
void resize(double factor) {
    size *= factor; // reduce o aumenta proporcionalmente

}
void rePosiciona(double factor) {
    position.add(Vector2(factor,0));//a la derecha segun factor
}
void resetSize(){
  size = Vector2(20, 40);
}
Vector2 getPosition(){
  return position;
}
void setPosition(double x, double y) {
    position.x = x;
    position.y = y;
}

@override
  void update(double dt) { //cuando se actualize
    /*super.update(dt);
    tAcum += dt;//tiempo acum
    if (tAcum >= 0.5) { // cada medio segundo
      audioPlayer.play(AssetSource('sounds/dice-sound.mp3'));
      tAcum = 0;
    }*/
  }

  @override
  void onStart() {
    
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.play(AssetSource('sounds/dice-sound.mp3'));
  }

}
