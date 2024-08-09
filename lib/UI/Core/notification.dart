// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class notif extends StatelessWidget {
  const notif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Text(
            'Notifications',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 14, 170, 113),
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ),
      ),
    ); 
  }
}