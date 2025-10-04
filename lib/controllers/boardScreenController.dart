import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/components/Ficha.dart';
import 'package:snake_ladder_app/game/snakeLadderGame.dart';
import 'package:snake_ladder_app/model/LadderPositions.dart';
import 'package:snake_ladder_app/model/SnakePositions.dart';
import 'package:snake_ladder_app/model/preguntas.dart';
import 'package:snake_ladder_app/service/gameService.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:snake_ladder_app/widgets/opcionesDialog.dart';
import 'package:snake_ladder_app/widgets/widgets.dart';



class Boardscreencontroller extends GetxController {
  Map<int, Offset> mapPosCeldas = {};
  double celdaAlt = 0;
  double celdaAnc = 0;
  Ficha? ficha1 ;
  double nroCelda = 0;
  final List<String> imagePathsList = [//imagenes dice
    'assets/images/dice/dice1.png',
    'assets/images/dice/dice2.png',
    'assets/images/dice/dice3.png',
    'assets/images/dice/dice4.png',
    'assets/images/dice/dice5.png',
    'assets/images/dice/dice6.png',
    'assets/images/dice/dice7.png',
    'assets/images/dice/dice8.png',
    'assets/images/dice/dice9.png',
    'assets/images/dice/dice10.png',
    'assets/images/dice/dice11.png',
    'assets/images/dice/dice12.png',
  ];
  final List<String> imageDiceList = [
    'assets/images/dice/dice_0.png',//colocar valor nominal indice 0
    'assets/images/dice/dice_1.png',//desde indice 1
    'assets/images/dice/dice_2.png',
    'assets/images/dice/dice_3.png',
    'assets/images/dice/dice_4.png',
    'assets/images/dice/dice_5.png',
    'assets/images/dice/dice_6.png',    
  ];
  late Timer _timerDice;
  late Timer _timerDuracionDice;
  RxInt indiceDice = 0.obs;
  //final sgame = Snakeladdergame();
  List<Offset> posDestinoList=[];//lista de posiciones destino
  RxList<String> mensajeComicList = <String>[].obs;
  Rx<Offset> posMsjComic = Offset(100, 300).obs;//posicion del comic
  RxInt numTurnoDice = 0.obs;  //valor del dice
  Random random = Random();
  RxList<LadderPositions> posEscalerasList = <LadderPositions>[].obs;
  RxList<SnakePositions> posSerpientesList = <SnakePositions>[].obs;
  List<Preguntas> preguntasList=[];//la lista de preguntas cargada desde json
  int posPreguntaFicha = 0;
  Rx<String> preguntaFicha = "".obs;//la pregunta que se mostrara en el dialogo
  final AudioPlayer audioPlayer = AudioPlayer();//para sonidos
  RxInt numFicha = 0.obs;//para el array de fichas 0 = jugador 1 ficha actual
  int numTotalFichas = 0; //numero de fichas que jugaran 4
  Rx<String> nombreFicha0 ="".obs;//nombre a desplegar en la pantalla
  Rx<String> nombreFicha1 ="".obs;
  Rx<String> pathFicha0 ="".obs;//nombre a desplegar en la pantalla
  Rx<String> pathFicha1 ="".obs;
  var loadingImage = true.obs;//para indicar que esta en loading para imagenes
  List<String> nombresList=[];//la lista de nombres de los jugadores
  int numTabla = 0;//numero de tabla




  late Snakeladdergame sgame;//se asigna cuando ya construye la vista widgets
  int numFichaBkp = 0;//copia del numero de ficha

  Widgets widgets = Widgets();//widgets externos

  






  

  
  



  @override
  void onInit() async {
    //Get.put(sgame);
    //sgame = Get.find<Snakeladdergame>();
    print("entro onInit Boardscreencontroller");
    
    preguntasList.assignAll(await GameService.cargarPreguntas('assets/data/preguntas_es.json'));
    preguntasList.shuffle();//desordenamos la lista de preguntas
    //iniciarFichas();
   
    
  }

  Future<void> cargarPosiciones() async {
    posEscalerasList.assignAll(await GameService.cargarPosLadder('assets/data/ladder_positions.json',numTabla.toString()));
    posSerpientesList.assignAll(await GameService.cargarPosSnake('assets/data/snake_positions.json',numTabla.toString()));
    
  }
  void iniciarNombresFichas(){//se invoca desde flame game
    nombreFicha0.value = sgame.fichaList[numFicha.value].nombre;
    nombreFicha1.value = sgame.fichaList[numFicha.value+1].nombre;

    pathFicha0.value = sgame.fichaList[numFicha.value].pathImage;
    pathFicha1.value = sgame.fichaList[numFicha.value+1].pathImage;

    print('paths de imagenes cargadas ${pathFicha0.value}  ${pathFicha1.value} ');


  }
  

  void generarMapaPosiciones(double screenAnc,double screenAlt) {
    celdaAlt = screenAlt*0.078;
    celdaAnc = screenAnc*0.10;
    int numero = 1;
      for (int fila = 9; fila >= 0; fila--) {
        for (int col = 0; col < 10; col++) {
          // zig-zag: si la fila es par, invertimos la dirección
          int x = (fila % 2 != 0) ? col : 9 - col;
          mapPosCeldas[numero] = Offset(x * celdaAnc, (fila * celdaAlt)+screenAlt*0.112);//para bajar las celdas 
          numero++;
        }
      }
      mapPosCeldas[0] = mapPosCeldas[1]!;//copiamos la posicion de celda 1 a la posicion de celda 0 para iniciar los sprites en posicion celda 1 para que salte a posicion celda 1
    }
    /*void moverFicha_action(){
      nroCelda ++;
      sgame.moverFichaAPosicion(mapPosCeldas[nroCelda]!.dx,mapPosCeldas[nroCelda]!.dy);
      
    }*/
    

    void lanzar_action() async{
      audioPlayer.play(AssetSource('sounds/dice-sound.mp3'));

      mensajeComicList.clear();//limpiar mensajes
      imagePathsList.shuffle();//desordenar las imagenes

      numTurnoDice.value = 0; //numero del dice reset
      _timerDice = Timer.periodic(Duration(milliseconds: 40), (_) {
        indiceDice.value = (indiceDice.value + 1) % imagePathsList.length;//indiceDice: numero para despliegue de la imagen
      });

      _timerDuracionDice = new Timer(const Duration(milliseconds: 700), () {//duracion de la animacion de imagenes
          _timerDice.cancel();//cancelar el rote de imagenes de dice
          numTurnoDice.value = random.nextInt(6)+1; //numero randomico segun formula para el dice
          //numTurnoDice.value = 1;  // para que incremente de uno en uno
          print('numTurnoDice.value ${numTurnoDice.value}');
          if(sgame.fichaList[numFicha.value].nroCeldaActual+numTurnoDice.value>100){//para no sobrepasar el 100
            //sgame.fichaList[numFicha.value].nroCeldaActual = sgame.fichaList[numFicha.value].nroCeldaActual -1;//reducir en una celda
            //numTurnoDice.value = 1;//ir al mismo lugar
            posDestinoList = [];//resetear la lista de posiciones destino
            posDestinoList.add(mapPosCeldas[sgame.fichaList[numFicha.value].nroCeldaActual]!); //saltar a la misma celda
            Future.delayed(const Duration(seconds: 1), () {
              sgame.saltarFichaAPosiciones(posDestinoList,numFicha.value);
            });
            return;
          }
          posDestinoList = [];//resetear la lista de posiciones destino
          int  i=0;//variable para actualizar la posicion del dialogo
          for(i=sgame.fichaList[numFicha.value].nroCeldaActual+1;
          i<=sgame.fichaList[numFicha.value].nroCeldaActual+numTurnoDice.value;// mas el numero que toco en el dice
          i++){//empieza del nroCeldaActual de la ficha
            posDestinoList.add(mapPosCeldas[i]!);
          }
          
          //un delay
          Future.delayed(const Duration(seconds: 1), () {//despues de 1 segundo se hara el salto de la ficha
            // Code to be executed after 2 seconds
            //sgame.fichaList[numFicha.value].resetSize();//resetear tamaño deberias ser todas las fichas
            sgame.saltarFichaAPosiciones(posDestinoList,numFicha.value);//saltar las posiciones registradas            
            sgame.fichaList[numFicha.value].nroCeldaActual+=numTurnoDice.value;//actualizamos la posicion actual de la ficha - se actualiza el valor en la ficha del array
            

            
            
          });
          
          
      });
      //de acuerdo a un numero saltar hasta la ficha 5
      
    }
    void finalizarSaltos_action() async{//verificar si tiene subir escaleras o bajar la vibora

      Path curvSerpDestino = Path();
      //actualizar el valor del dice

            posDestinoList =[];
            posDestinoList = crearSaltosEscalera(sgame.fichaList[numFicha.value].nroCeldaActual); //calculamos si coincide con la escalera posIni
            curvSerpDestino = crearCurvasSerpiente(sgame.fichaList[numFicha.value].nroCeldaActual);
            //es asincrono por eso debe venir despues de finalizar los saltos
            if(posDestinoList.length>0){//verificamos que se generaron los Offset
              await sgame.saltarFichaPorEscalera(posDestinoList,numFicha.value);//saltar las posiciones registradas            
              //sgame.ficha.nroCeldaActual+=numTurnoDice.value;//actualizamos la posicion actual de la ficha
              //print("finalizo saltar escalera....");
            }
            else if(curvSerpDestino.computeMetrics().isNotEmpty){//si tiene curvas para la serpiente
              await sgame.bajarFichaPorSerpiente(curvSerpDestino,numFicha.value);
            }else{

              if(sgame.fichaList[numFicha.value].nroCeldaActual==100){ //verificacion ganador juego
                Get.dialog(
                widgets.ganadorPartidaDialog(sgame.fichaList[numFicha.value].nombre));//con el nombre del ganador
                return;
              }
              
              //ya no hay mas que recorrer
              preguntaFicha.value = obtienePreguntaFicha();
              //print(preguntaFicha.length/20);
              posMsjComic.value = mapPosCeldas[sgame.fichaList[numFicha.value].nroCeldaActual]!;//posicion del comic finalizando la animacion          
              //posMsjComic.value.dy = posMsjComic.value.dy - (preguntaFicha.length/20);
              //deducir posicion del comic metodo invocado desde el sprite flame game
              print(' posicion ficha dx ${posMsjComic.value.dx} dy ${posMsjComic.value.dy}' );
              
              audioPlayer.play(AssetSource('sounds/mensaje.mp3'));
              mensajeComicList.add(preguntaFicha.value);
              
              rePosicionaFicha();
              actNumFicha();
            }
            
      

    }
    void finalizaSaltosEscalera_action() async{
        if(sgame.fichaList[numFicha.value].nroCeldaActual==100){ //verificacion ganador juego
          Get.dialog(
          widgets.ganadorPartidaDialog(sgame.fichaList[numFicha.value].nombre));//con el nombre del ganador
          return;
        } 
        //ya no hay mas que recorrer
        posMsjComic.value = mapPosCeldas[sgame.fichaList[numFicha.value].nroCeldaActual]!;//posicion del comic finalizando la animacion (en ficha actual)
        
        audioPlayer.play(AssetSource('sounds/mensaje.mp3'));
        //deducir posicion del comic metodo invocado desde el sprite flame game
        mensajeComicList.add(obtienePreguntaFicha());
        rePosicionaFicha();//reducir el tamaño si existen posiciones similares
        actNumFicha();
    }
    void finalizarBajarPorSerpiente_action() async{
        if(sgame.fichaList[numFicha.value].nroCeldaActual==100){ //verificacion ganador juego
          Get.dialog(
          widgets.ganadorPartidaDialog(sgame.fichaList[numFicha.value].nombre));//con el nombre del ganador
          return;
        } 
        //ya no hay mas que recorrer
        posMsjComic.value = mapPosCeldas[sgame.fichaList[numFicha.value].nroCeldaActual]!;//posicion del comic finalizando la animacion (en ficha actual)
        
        audioPlayer.play(AssetSource('sounds/mensaje.mp3'));
        //deducir posicion del comic metodo invocado desde el sprite flame game
        mensajeComicList.add(obtienePreguntaFicha());
        rePosicionaFicha();
        actNumFicha();
    }
    
    String obtienePreguntaFicha(){
      posPreguntaFicha ++;
      return preguntasList[posPreguntaFicha].pregunta!;
    }
    void actNumFicha(){
      
      
      numFicha.value++;      
      
      if(numFicha.value+1>numTotalFichas){//maximo dos jugadores 0 ,1 2 es una constante es que numFicha comienza de 0
        
        numFicha.value=0;
      }
      

      if(numFicha.value%2==0){// es par comienza de 0 la ficha actual [0, 2]        
        nombreFicha0.value = sgame.fichaList[numFicha.value].nombre;
        pathFicha0.value = sgame.fichaList[numFicha.value].pathImage;
        print('comparacion ${sgame.fichaList.length} ${numFicha.value}');
        if(sgame.fichaList.length<=numFicha.value+1){//comparar la longitud de la lista con el numero de ficha + 1
          
          nombreFicha1.value = sgame.fichaList[0].nombre;//colocar nigun jugador "" 
          pathFicha1.value = sgame.fichaList[0].pathImage; //"player_none.png" 
        }else{
          nombreFicha1.value = sgame.fichaList[numFicha.value+1].nombre;
          pathFicha1.value = sgame.fichaList[numFicha.value+1].pathImage;
        }
      }
      print('valor de numFicha ${numFicha.value}');


      

    }
    Future<void> rePosicionaFicha() async{//para reducir el tamaño si existen posiciones similares
    double posFicha = 3*numTotalFichas.toDouble();
      for(int i = 0;i< sgame.fichaList.length;i++){//no mover a la ficha que tiene el turno
        if(numFicha.value!=i &&  sgame.fichaList[numFicha.value].nroCeldaActual == sgame.fichaList[i].nroCeldaActual ){//la ficha actual con las fichas y sus posiciones
          //sgame.fichaList[numFicha.value].resize(0.7);
          //sgame.fichaList[i].resize(0.7);
          posFicha -=3;//invertir ya que no se muestra con incremento
          print('ficha ${i} posicion ${posFicha} ');

          //sgame.fichaList[numFicha.value].rePosiciona(posFicha);//hacia la derecha recorrer la ficha actual todas y reacomodar a las fichas que tienen la misma posicion
          sgame.fichaList[i].rePosiciona(posFicha);//hacia la derecha recorrer a las fichas que tienen la misma posicion

          //break;
        }
      }
    }

    //deducir si coincide con la posicion inicial para mover a la posicion final
    List<Offset> crearSaltosEscalera(int nroCeldaActual){//con cantidad de offsets a generar
      for(LadderPositions p in posEscalerasList){
        if(p.ubicIni==nroCeldaActual){
          sgame.fichaList[numFicha.value].nroCeldaActual = p.ubicFin!;//actualizamos la posicion final de la ficha
          //generar la serie de pasos hacia p.ubicFin
          return List.generate(
                    p.pasos!,
                    (i) => Offset.lerp(mapPosCeldas[p.ubicIni], mapPosCeldas[p.ubicFin], i / (p.pasos! - 1))!,
                  );
        }
      }
      return [];
    }

    Path crearCurvasSerpiente(int nroCeldaActual){//con cantidad de offsets a generar
      for(SnakePositions p in posSerpientesList){
        if(p.ubicFin==nroCeldaActual){
          sgame.fichaList[numFicha.value].nroCeldaActual = p.ubicIni!;//actualizamos la posicion final de la ficha
          //generar la serie de pasos hacia p.ubicFin
          
          return generarCurvasSerpiente( mapPosCeldas[p.ubicFin]!,mapPosCeldas[p.ubicIni]!);
        }
      }
      return Path();
    }

    Path generarCurvasSerpiente(Offset inicio, Offset fin) {
      final path = Path();

      final dx = (fin.dx - inicio.dx).abs();
      final dy = (fin.dy - inicio.dy).abs();

      final control1 = Offset(inicio.dx + dx / 3, inicio.dy - dy / 2);
      final control2 = Offset(fin.dx - dx / 3, fin.dy + dy / 2);

      path.moveTo(inicio.dx, inicio.dy);
      path.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, fin.dx, fin.dy);

      return path;
    }

    void mostrarOpciones_action(){
      Get.dialog(
        OpcionesDialog(        
        onMenu: (){
          numFicha.value = 0;//resetear el numero de ficha
          mensajeComicList.clear();//borrar los mensajes

          Get.toNamed('/', arguments: {//a la pantalla inicial          
          });
        }, 
        onReintentar:(){
          //posicionar en 0 los jugadores
          for(int i = 0;i< sgame.fichaList.length;i++){//no mover a la ficha que tiene el turno                  
          sgame.fichaList[i].setPosition(mapPosCeldas[0]!.dx,mapPosCeldas[0]!.dy);//hacia la derecha recorrer a las fichas que tienen la misma posicion
          sgame.fichaList[i].nroCeldaActual = 0;
          //break;        
          }
          Get.back();

        },
        onRetornar: (){
          Get.back();
        }

        )
      );
    }



    @override
      void onClose() {
        //_timerDuracionDice.cancel();
        super.onClose();
      }
    

  
}