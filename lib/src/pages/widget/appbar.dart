import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Appbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const Appbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 242, 220),
      height: 120,
      padding: EdgeInsets.only(
      top: 30,left: 17,
      ),
      width: MediaQuery.of(context).size.width *1,
      
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              letterSpacing: -3,
              color: Color.fromARGB(255, 44, 72, 61)
            )
          ),
        ],
      ),
      

    );
  }
  
  @override

  Size get preferredSize => const Size.fromHeight(500);
  
}