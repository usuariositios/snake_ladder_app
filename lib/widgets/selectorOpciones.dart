import 'package:flutter/material.dart';

class SelectorOpciones extends StatefulWidget {
  final List<(int,String)> opciones;
  final ValueChanged<int> onSeleccion;
  final int opcionInicial;

  const SelectorOpciones({
    Key? key,
    required this.opciones,
    required this.onSeleccion,
    required this.opcionInicial
    
  }) : super(key: key);

  @override
  _SelectorOpcionesState createState() => _SelectorOpcionesState();
}

class _SelectorOpcionesState extends State<SelectorOpciones> {
  int? seleccionActual;

  @override
  void initState() {
    super.initState();
    // Si hay opción inicial, úsala, si no, deja null
    seleccionActual = widget.opcionInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: widget.opciones.map((opcion) {
        return ChoiceChip(
          label: Text(opcion.$2),//la cadena string de la opcion
          selected: seleccionActual == opcion.$1,//para visualizar como seleccionada la opcion
          onSelected: (bool seleccionado) {
            setState(() {
              seleccionActual = opcion.$1;
            });
            widget.onSeleccion(opcion.$1);
          },
        );
      }).toList(),
    );
  }
}