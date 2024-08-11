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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Container(
          child: Text(
            'Notifications',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600
              )
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){}, 
            child: Align(
              child: Text(
                'Mark all as read',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color:Colors.black54,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  
                ],
              ),
            ],
          ),
        ],
      ),
    ); 
  }
}