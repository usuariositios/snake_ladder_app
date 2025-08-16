import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:snake_ladder_app/model/LadderPositions.dart';
import 'package:snake_ladder_app/model/SnakePositions.dart';
import 'package:snake_ladder_app/model/preguntas.dart';

//import 'package:snake_ladder1/model/SnakePositions.dart';
//import 'package:snake_ladder1/model/preguntas_juego.dart';

class GameService {
  static var client = http.Client();

Future<void> fetchData(int questionIndex, bool answer) async {
  final url = Uri.parse('https://tuapi.com/verificar_respuesta');
  

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "question_id": questionIndex,
        "answer": answer,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Respuesta del servidor: ${data['message']}");
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Error en la solicitud: $e");
  }
}




  static Future<List<LadderPositions>> cargarLadderPosiciones(String nomArchivo) async {
    final String contenido = await rootBundle.loadString(nomArchivo);
    final List<dynamic> jsonData = jsonDecode(contenido);
    return jsonData.map((item) => LadderPositions.fromJson(item)).toList();
  }

  static Future<List<LadderPositions>> cargarPosLadder(String nomArchivo,String posicion) async {
    final String response = await rootBundle.loadString(nomArchivo);
    final data = await json.decode(response);
    List<dynamic> jsonData = data['$posicion'];
    return jsonData.map((item) => LadderPositions.fromJson(item)).toList();
  }

  static Future<List<SnakePositions>> cargarPosSnake(String nomArchivo,String posicion) async {
    final String response = await rootBundle.loadString(nomArchivo);
    final data = await json.decode(response);
    List<dynamic> jsonData = data['$posicion'];
    return jsonData.map((item) => SnakePositions.fromJson(item)).toList();
  }

  static Future<List<Preguntas>> cargarPreguntas(String nomArchivo) async {
    final String contenido = await rootBundle.loadString(nomArchivo);
    final List<dynamic> jsonData = jsonDecode(contenido);
    return jsonData.map((item) => Preguntas.fromJson(item)).toList();
  }
  
  

  

  
}