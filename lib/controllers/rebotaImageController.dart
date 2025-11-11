import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RebotaImageController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  var offsetY = 0.0.obs;
  var isAnimating = false.obs; // indicador externo

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),//duracion de la animacion
    );

    animation = Tween<double>(begin: -9, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animation.addListener(() {
      offsetY.value = animation.value;
    });

    ever(isAnimating, (bool playing) async {//controla la animacion
      if (playing) {        
        animationController.repeat(reverse: true);        
        Future.delayed(const Duration(seconds: 2), () {
          animationController.stop();
          
        });
      } else {
        animationController.stop();
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}