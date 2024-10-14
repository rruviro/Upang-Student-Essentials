import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/apiservice/authApi/aurepoimpl.dart';
import 'package:use/frontend/Authentication/StudentLogin.dart';
import 'package:use/backend/bloc/authentication/authentication_bloc.dart';
import 'package:use/frontend/colors/colors.dart';

import '../frontend/Authentication/AdminLogin.dart';

void main() {
  runApp(const Welcome());
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

final AuthenticationBloc authBloc =
    AuthenticationBloc(AuthenticationImplementation());

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  final List<String> _images = [
    'assets/splash_image/upang.jpg',
    'assets/splash_image/upang1.jpg',
    'assets/splash_image/upang2.jpg',
  ];

  int _currentIndex = 0;
  double _opacity = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _opacity = 0.0;

        Future.delayed(Duration(milliseconds: 1000), () {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _images.length;
            _opacity = 1.0;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: authBloc,
        listenWhen: (previous, current) => current is ActionState,
        buildWhen: (previous, current) => current is! ActionState,
        listener: (context, state) {
          if (state is StudentPageState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StudnetLogin()));
          } else if (state is AdminPageState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminLogin()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AuthLoadingState():
              return CircularProgressIndicator();
            default:
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: Duration(milliseconds: 1000),
                          child: Image.asset(
                            _images[_currentIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CustomPaint(
                        painter: WhiteBackgroundPainter(),
                        child: Container(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          // <-- Wrap Column with SingleChildScrollView
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 50.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 450),
                                Text(
                                  "Welcome to\nUpang Student Essentials",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Where you can reserve and check the availability of the items you need.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 30),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {
                                          authBloc.add(StudentPageEvent());
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.3),
                                          side: BorderSide(
                                              color: primary_color, width: 2.0),
                                          foregroundColor: primary_color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: Text(
                                          "Student",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          authBloc.add(AdminPageEvent());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary_color,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: Text(
                                          "Admin",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
          }
        });
  }
}

class WhiteBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(0, 255, 255, 255),
          Color.fromARGB(170, 255, 255, 255).withOpacity(0.7),
          Colors.white,
        ],
        stops: [0.2, 0.5, 1.0],
      ).createShader(
          Rect.fromLTWH(0, size.height * 0.3, size.height * -0.1, size.width));

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
