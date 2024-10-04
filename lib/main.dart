// ignore_for_file: prefer_const_constructors
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/apiservice/adminApi/arepoimpl.dart';
import 'package:use/backend/apiservice/authApi/aurepoimpl.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/bloc/authentication/Route.dart';
import 'package:use/backend/bloc/authentication/authentication_bloc.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  AwesomeNotifications().initialize(
  null,
  [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Color(0xFF9D50B8),
      ledColor: Colors.white,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      playSound: true,
    )
  ],
  debug: true

  ).then((_) => print("Notification channel initialized successfully"));


  _requestPermissions();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(AuthenticationImplementation()),
        ),
        BlocProvider(create: (context) => StudentExtendedBloc(StudentRepositoryImpl())),
        BlocProvider(create: (context) => StudentBottomBloc()),
        BlocProvider(create: (context) => AdminExtendedBloc(AdminRepositoryImpl())),
        BlocProvider(create: (context) => AdminBottomBloc()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}

void _requestPermissions() {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}