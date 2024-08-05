// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override 
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final itemsBN = [
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.home,
        size: 20.0
      ), 
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 10
        ),
      ),
      
      unselectedColor: Colors.white,
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.campaign,
        size: 20.0
      ), 
      title: const Text(
        'Announcement',
        style: TextStyle(
          fontSize: 10
        ),
      ),
      unselectedColor: Colors.white,
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
      unselectedColor: Colors.white,
      selectedColor: Colors.white,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 35, 
          height: 35, 
          child: Image.asset('assets/logo.png'),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Departments',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'fonts/Inter-Regular.ttf',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Choose your perspective department for --',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontFamily: 'fonts/Inter-Regular.ttf',
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 3), 
                    ListBody(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 14, 170, 113)
                            ),
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Color.fromARGB(255, 14, 170, 113),
        items: itemsBN,
        currentIndex: _currentIndex,
        duration: Duration(seconds: 1),
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}