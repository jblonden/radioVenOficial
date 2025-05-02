import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawerHeader extends StatelessWidget {
  final bool isColapsed;
  

  const CustomDrawerHeader({
    super.key,
    required this.isColapsed,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle styleTitulo = GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700,color: const Color.fromARGB(255, 228, 148, 0));
    TextStyle styleDetalle = GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.w600,color:const Color.fromARGB(255, 102, 102, 102));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 80,
      width: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/logo-ven.png',
          width: 90,
          height: 80,
        ),
      ),
    );
  }
}
