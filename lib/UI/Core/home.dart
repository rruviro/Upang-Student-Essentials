// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Upang Student Essentials',
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
          SizedBox(width: 15),
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
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Choose your perspective department for --',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(146, 0, 0, 0),
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 10), 
                    ListBody(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 14, 170, 113),
                                  Color.fromARGB(255, 14, 170, 113),
                                ],
                                stops: [
                                  0.60,
                                  0.90
                                ],
                              ),
                              // color: Color.fromARGB(255, 14, 170, 113),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: Offset(1, 8),
                                ),
                              ],
                              // image: DecorationImage(
                              //   image: AssetImage('assets/vanguards.png'),
                              //   fit: BoxFit.cover, 
                              // ),
                            ),
                            height: 170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 20.0,
                                    left: 30.0
                                  ),
                                  child: Text(
                                    'Health Sciences',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle (
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5.0,
                                    left: 30.0
                                  ),
                                  child: Text(
                                    'Courses :',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle (
                                        fontSize: 10,
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 60.0,
                                    left: 30.0
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_circle_right_outlined,
                                        color: Colors.white54,
                                        size: 20
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Show more courses',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle (
                                            fontSize: 10,
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
      bottomNavigationBar: Container (
        color: Color.fromARGB(255, 14, 170, 113),
        child: Stack(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(
                right: 120.0,
                left: 120.0
              ),
              child: SalomonBottomBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
                items: itemsBN,
                currentIndex: _currentIndex,
                duration: Duration(seconds: 1),
                onTap: (index) => setState(() {
                  _currentIndex = index;
                })
              ),
            ),
          ],
        ),
      )
    );
  }
}