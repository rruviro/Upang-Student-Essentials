import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/SERVICES/bloc/authentication/authentication_bloc.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/frontend/admin/navigation.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/navigation.dart';
import 'package:use/frontend/authentication/StudentLogin.dart';
import 'package:use/frontend/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _textFadeAnimation;
  bool _textVisible = false;
  final AuthenticationBloc authBloc = AuthenticationBloc();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward().then((_) async {
      final SharedPreferences login = await SharedPreferences.getInstance();
      String studentId = login.getString('StudentId') ?? '';
      String password = login.getString('Password') ?? '';
      String adminId = login.getString('adminID') ?? '';
      String apassword = login.getString('1Password') ?? '';
      bool islogin = login.getBool('isLogin') ?? false;
      bool? isAdmin = login.getBool('isAdmin');
      if (isAdmin == false) {
        if (islogin == true) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BlocProvider<StudentBottomBloc>.value(
                value: studentBloc, child: SHomeBase(studentId: studentId)),
          ));
        } else {
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              _controller.reverse().then((_) {
                _navigateToWelcomeScreen();
              });
            }
          });
        }
      } else {
        if (islogin == true) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BlocProvider<StudentBottomBloc>.value(
                value: studentBloc, child: HomeBase()),
          ));
        } else {
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              _controller.reverse().then((_) {
                _navigateToWelcomeScreen();
              });
            }
          });
        }
      }
    });

    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _textVisible = true;
        });
      }
    });
  }

  void _navigateToWelcomeScreen() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is WelcomePageState) {
          //need to fix
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 300, width: 380, fit: BoxFit.fill));
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child:
                        Image.asset('assets/logo.png', width: 160, height: 160),
                  ),
                  if (_textVisible)
                    FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Padding(
                        padding: EdgeInsets.only(top: 230),
                        child: Text(
                          'MAKING LIVES BETTER THROUGH EDUCATION',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
