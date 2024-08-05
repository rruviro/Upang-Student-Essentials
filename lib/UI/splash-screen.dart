// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Text (
          'Upang Student Essential',
          style: TextStyle(
            fontSize: 10,
            height: 8,
            color: Colors.black45,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}