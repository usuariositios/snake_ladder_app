import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GaleriaImage extends StatefulWidget {
  
  final Function(int) onSiguiente_action;
  final Function(int) onAnterior_action;
  const GaleriaImage({super.key,
  required this.onSiguiente_action,
  required this.onAnterior_action});

  @override
  State<GaleriaImage> createState() => _GaleriaImageState();
}

class _GaleriaImageState extends State<GaleriaImage> {
  int currentIndex = 0;
  
  

  final List<String> imagenes = [
    "assets/images/tabla_snake_ladder0.svg",
    "assets/images/tabla_snake_ladder1.svg",
    "assets/images/tabla_snake_ladder2.svg",
  ];

  void siguiente() {
    if (currentIndex < imagenes.length - 1) {
      setState(() {
        currentIndex++;
      });
    }else{
      setState(() {
        currentIndex=0;//reset
      });
    }
    widget.onSiguiente_action(currentIndex);//enviamos valor desde el widget
  }

  void anterior() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }else{
      setState(() {
        currentIndex = imagenes.length - 1;
      });
    }
    widget.onAnterior_action(currentIndex);//enviamos valor desde el widget
  }

  @override
  Widget build(BuildContext context) {

    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Imagen actual
        SvgPicture.asset(
          imagenes[currentIndex],          
          height: screenAlt*0.6,
          width: screenAnc*0.6,
        ),

        

        

        // Botones de navegación
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: anterior,
              child: const Icon(Icons.arrow_back_ios),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: siguiente,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),

        const SizedBox(height: 5),

        // Indicador de posición
        Text(
          "${currentIndex + 1} / ${imagenes.length}",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}