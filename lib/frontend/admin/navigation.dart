import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:use/frontend/admin/announcement/announcement.dart';
<<<<<<< Updated upstream
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
=======
import 'package:use/frontend/admin/history.dart';
>>>>>>> Stashed changes
import 'package:use/frontend/admin/home/home.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/admin/profile/profile.dart';

<<<<<<< Updated upstream
=======
import '../../backend/bloc/BottomNavCubit.dart';
import '../colors/colors.dart';

>>>>>>> Stashed changes
class HomeBase extends StatelessWidget {
  const HomeBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upang Admin Essentials',
        home: HomeScreen(),
      ),
    );
  }
  
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HometopLevelPagestate();
}

<<<<<<< Updated upstream
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
=======
class _HometopLevelPagestate extends State<HomeScreen> {
  late PageController pageController;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int page = 0;

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
<<<<<<< Updated upstream
          body: destination.elementAt(state.tabIndex),
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
                      currentIndex: state.tabIndex,
                      duration: Duration(seconds: 1),
                      onTap: (index) => setState(() {
                        BlocProvider.of<AdminBottomBloc>(context)
                          .add(TabChange(tabIndex: index));
                      }),
                    ),
                  ),
=======
          backgroundColor: Colors.white,
          body: _mainWrapperBody(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(1, -0.5),
                ),
              ]
            ),
            child: _icons(context)
          )
        );
      },
    );
  }


  double iconSize = 20.0;
  double fontSize = 8.0;

  BottomAppBar _icons(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.home_outlined,
                  page: 0,
                  label: "Home",
                  filledIcon: Icons.home,
                  iconSize: iconSize, // Pass the icon size
                  fontSize: fontSize,  // Pass the font size
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.campaign_outlined,
                  page: 1,
                  label: "Announcement",
                  filledIcon: Icons.campaign_rounded,
                  iconSize: iconSize, // Pass the icon size
                  fontSize: fontSize,  // Pass the font size
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.history_edu_outlined,
                  page: 2,
                  label: "History",
                  filledIcon: Icons.history_edu,
                  iconSize: iconSize, // Pass the icon size
                  fontSize: fontSize,  // Pass the font size
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.person_outline,
                  page: 3,
                  label: "Profile",
                  filledIcon: Icons.person,
                  iconSize: iconSize, // Pass the icon size
                  fontSize: fontSize,  // Pass the font size
>>>>>>> Stashed changes
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> topLevelPages = const [
    Home(),
    Announcement(),
    History(),
    Profile(),
  ];

  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelPages,
    );
  }

  // Bottom Navigation Bar Single item - MainWrapper Widget
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required int page,
    required String label,
    required filledIcon,
    required double iconSize, // New parameter for icon size
    required double fontSize,  // New parameter for font size
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color: context.watch<BottomNavCubit>().state == page
                  ? primary_color
                  : Colors.grey,
              size: iconSize, // Use the passed icon size
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                color: context.watch<BottomNavCubit>().state == page
                    ? primary_color
                    : Colors.grey,
                fontSize: fontSize, // Use the passed font size
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
