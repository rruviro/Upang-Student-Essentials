// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:use/SERVICES/bloc/authentication/Route.dart';
void main() {
<<<<<<< Updated upstream
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
=======
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
      ],
      child: MyApp(),
    ),
  );
>>>>>>> Stashed changes
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