import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';


class Ficha extends SpriteComponent {
  Ficha({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,
  }) : super(position: position, size: size, sprite: sprite);
int nroCeldaActual=0;//celda actual en 0 para que salte a 1


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

  Future<void> saltarVariasPosiciones(List<Offset> destinoLists) async {//aqui recibir el array de 
    final double alturaSalto = -100; // altura negativa = hacia arriba

    /*final moveUp = MoveByEffect(
      Vector2(0, alturaSalto),
      EffectController(duration: 1, reverseDuration: 0),
    );*/
    

    
    

    for (final destino in destinoLists) {
      final efectos = [
          MoveEffect.by(
            Vector2(0, -80), // Move 50 pixels up
            EffectController(duration: 0.3), // Quick jump up
          ),
          MoveEffect.to(
            Vector2(destino.dx, destino.dy+80),//para bajar la ficha
            EffectController(duration: 0.4),
          )
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
    final efecto = MoveAlongPathEffect(
      path,
      EffectController(duration: 2.0, curve: Curves.easeInOut), // duración y curva
      absolute: true, // usa coordenadas absolutas
    );
  add(efecto);
  
  await efecto.completed;//esperar a que los efectos terminen
}
}