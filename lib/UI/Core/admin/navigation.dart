// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:use/UI/Core/admin/announcement/announcement.dart';
import 'package:use/UI/Core/admin/home/home.dart';
import 'package:use/UI/Core/admin/profile/profile.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Upang Admin Essentials',
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override 
  State<HomeScreen> createState() => _Homedestinationtate();
}

class _Homedestinationtate extends State<HomeScreen> {
  int _currentIndex = 0;
  final itemsBN = [
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.home_outlined,
        size: 20.0
      ), 
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 10
        ),
      ),
      activeIcon: Icon(Icons.home),
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.campaign_outlined,
        size: 20.0
      ), 
      title: const Text(
        'Announcement',
        style: TextStyle(
          fontSize: 10
        ),
      ),
      activeIcon: Icon(Icons.campaign_rounded),
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.person_outline_sharp,
        size: 20.0
      ), 
      title: const Text(
        'Profile',
        style: TextStyle(
          fontSize: 10
        ),
      ),
      activeIcon: Icon(Icons.person),
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
    )
  ];

  final destination = const [
    Home(), Announcement(), Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destination[_currentIndex],
      bottomNavigationBar: Container (
        color: Color.fromARGB(255, 14, 170, 113),
        child: Stack(
          children: <Widget>[
            Align(
              heightFactor: 1.0,
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 260.0,
                ),
                child: SalomonBottomBar(
                  backgroundColor: Color.fromARGB(255, 14, 170, 113),
                  items: itemsBN,
                  currentIndex: _currentIndex,
                  duration: Duration(seconds: 1),
                  onTap: (index) => setState(() {
                    _currentIndex = index;
                  }),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}