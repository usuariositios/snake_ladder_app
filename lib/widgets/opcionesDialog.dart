import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpcionesDialog extends StatelessWidget {
  
  
  final VoidCallback onMenu;
  final VoidCallback onReintentar;
  final VoidCallback onRetornar;

  const OpcionesDialog({
    super.key,
    required this.onMenu,
    required this.onRetornar,
    required this.onReintentar,
  });

  @override
  Widget build(BuildContext context) {
    final screenAnc = MediaQuery.of(context).size.width;
    final screenAlt = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400), // 👈 limite para el scroll
        padding: const EdgeInsets.all(16),
        child: 
        
        
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ElevatedButton.icon(style: ElevatedButton.styleFrom(                          
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              minimumSize: Size(screenAnc*0.7,screenAlt*0.05),                        
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              iconAlignment: IconAlignment.start,
                              ),
              
                              onPressed: onMenu,
                              label: Text("menu".tr),
                              icon: Icon(Icons.menu),
                              
                        ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(                          
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              minimumSize: Size(screenAnc*0.7,screenAlt*0.05),                        
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              iconAlignment: IconAlignment.start,
                              ),
                              onPressed: onReintentar,
                              label: Text("reintentar".tr),
                              icon:Icon(Icons.refresh)
                        ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(                          
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              minimumSize: Size(screenAnc*0.7,screenAlt*0.05),                        
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              iconAlignment: IconAlignment.start,
                              ),
                              onPressed: onRetornar,
                              label: Text("retornar".tr),
                              icon:Icon(Icons.play_arrow)
                        ),
          
            
          ],
        )
      ),
    );
  }
}