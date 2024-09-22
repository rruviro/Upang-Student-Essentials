
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/apiservice/authApi/aurepo.dart';
import 'package:use/backend/apiservice/authApi/aurepoimpl.dart';
import 'package:use/backend/bloc/authentication/authentication_bloc.dart';
import 'package:use/frontend/splash-screen.dart';

class RouteGenerator {
  AuthenticationBloc authBloc = AuthenticationBloc(AuthenticationImplementation());
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthenticationBloc>.value(
            value: authBloc,
            child: SplashScreen(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
