import 'package:flutter/material.dart';
import 'dart:math';

class MensajeComic extends StatelessWidget {
  final String texto;
  final Offset offset;
  final Color color;
  final TextStyle? estiloTexto;
  final bool piquitoIzquierda;

  const MensajeComic({
    Key? key,
    required this.texto,
    required this.offset,
    this.color = Colors.white,
    this.estiloTexto,
    this.piquitoIzquierda = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;
    double posx = 0;
    bool conPiquIzquierda = true;

    //print('${offset.dx+100} $screenAnc');
    if(offset.dx+(screenAnc*0.4)>screenAnc){//calculo para que no sobrepase el borde derecho (screenAnc*0.4) es el ancho del dialogo
      posx = screenAnc-(screenAnc*0.4);//la posicion se disminuye hacia la izquierda si sobrepasa el borde
      conPiquIzquierda=false;
    }else{
      posx = offset.dx;//sino se mantiene normal
      conPiquIzquierda=true;
    }
    

    //offset.dx offset.dy

    return 
    Stack(
        clipBehavior: Clip.none,
        children: [
    
    Positioned(

      left: posx,
      bottom: screenAlt-offset.dy,//bottom empieza de arriba hacia abajo para invertir restar la altura total - la posicion y
      child: 
          Container(
            width: screenAnc*0.4,//el 30% del ancho del screen total
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),              
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Text(
              texto,
              style: estiloTexto ??
                  const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comic Sans MS', // Fuente estilo cómic (opcional)
                    color: Colors.black87,
                  ),
            ),
          )
         ),           
          Positioned(
            bottom: screenAlt-offset.dy-2,//bottom empieza de arriba hacia abajo para invertir restar la altura total - la posicion y
            left: offset.dx +7,//posicion referente a la ficha            
            child: Transform.rotate(
              angle: 45 * pi / 180,
              child: Container(
                width: 12,
                height: 12,
                color: color,
              ),
            ),
          ),
        ],
      
    );
  }
}