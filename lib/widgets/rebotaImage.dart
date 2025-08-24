import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder_app/controllers/rebotaImageController.dart';


class RebotaImage extends StatelessWidget {
  final String assetPath;
  final double size;
  final bool play; // indicador externo
  final String tag;

  const RebotaImage({
    super.key,
    required this.assetPath,
    this.size = 100,
    this.play = true,
    required this.tag
    
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RebotaImageController(),
                              tag: tag);

    // sincronizamos con el indicador externo
    controller.isAnimating.value = play;

    return Obx(() {
      return Transform.translate(
        offset: Offset(0, controller.offsetY.value),
        child: Image.asset(
          assetPath,
          width: size,          
        ),
      );
    });
  }
}