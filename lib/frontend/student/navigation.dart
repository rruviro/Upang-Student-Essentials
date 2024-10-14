// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/authentication/StudentLogin.dart';
import 'package:use/frontend/student/announcement/announcement.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/frontend/student/profile/profile.dart';

import '../../backend/bloc/BottomNavCubit.dart';
import '../colors/colors.dart';

class SHomeBase extends StatelessWidget {
  final String studentId;

  SHomeBase({required this.studentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentExtendedBloc>(
          create: (context) => StudentExtendedBloc(StudentRepositoryImpl())
            ..add(studentProfileGet(studentId)),
        ),
        BlocProvider<BottomNavCubit>(
          create: (context) => BottomNavCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upang Student Essentials',
        home: HomeScreen(studentID: studentId),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String studentID; // Added to pass studentID

  const HomeScreen({required this.studentID, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HometopLevelPagestate();
}

class _HometopLevelPagestate extends State<HomeScreen> {
  late PageController pageController;
  late StudentProfile studentProfile; // Make sure to handle nullability
  bool isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Load student profile when initializing
    context
        .read<StudentExtendedBloc>()
        .add(studentProfileGet(widget.studentID));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    BlocProvider.of<StudentBottomBloc>(context).add(TabChange(tabIndex: page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      listener: (context, state) {
        if (state is SpecificStudentLoadSuccessState) {
          setState(() {
            studentProfile = state.studentProfile;
            isProfileLoaded = true;
            if (studentProfile.status != "ACTIVE") {
              _showAccountLockedDialog();
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: isProfileLoaded
                ? _mainWrapperBody()
                : Center(
                    child: Lottie.asset('assets/lottie/loading.json',
                        height: 300, width: 380, fit: BoxFit.fill)),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    offset: Offset(1, -0.5),
                  ),
                ]),
                child: _icons(context)));
      },
    );
  }

  double iconSize = 20.0;
  double fontSize = 8.0;

  BottomAppBar _icons(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 69,
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
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.campaign_outlined,
                  page: 1,
                  label: "Announcement",
                  filledIcon: Icons.campaign_rounded,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.backpack_outlined,
                  page: 2,
                  label: "BackPack",
                  filledIcon: Icons.backpack,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.notifications_none,
                  page: 3,
                  label: "Notification",
                  filledIcon: Icons.notifications,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.person_outline,
                  page: 4,
                  label: "Profile",
                  filledIcon: Icons.person,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: [
        isProfileLoaded
            ? Home(studentProfile: studentProfile)
            : Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill)),
        isProfileLoaded
            ? Announcement(studentProfile: studentProfile)
            : Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill)),
        isProfileLoaded
            ? Bag(studentProfile: studentProfile, Status: studentProfile.status)
            : Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill)),
        isProfileLoaded
            ? notif(studentProfile: studentProfile)
            : Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill)),
        isProfileLoaded
            ? Profile(studentProfile: studentProfile)
            : Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill)),
      ],
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required IconData defaultIcon,
    required int page,
    required String label,
    required IconData filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<StudentBottomBloc>(context)
            .add(TabChange(tabIndex: page));
        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Icon(
                  context.watch<StudentBottomBloc>().state.tabIndex == page
                      ? filledIcon // Directly use filledIcon
                      : defaultIcon, // Directly use defaultIcon
                  color:
                      context.watch<StudentBottomBloc>().state.tabIndex == page
                          ? primary_color
                          : Colors.grey,
                  size: iconSize,
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    color: context.watch<StudentBottomBloc>().state.tabIndex ==
                            page
                        ? primary_color
                        : Colors.grey,
                    fontSize: fontSize,
                    fontWeight:
                        context.watch<StudentBottomBloc>().state.tabIndex ==
                                page
                            ? FontWeight.w600
                            : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAccountLockedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Account Locked'),
          content: Text('ACCOUNT IS LOCKED. PLEASE ENROLL.'),
          actions: [
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StudnetLogin()),
                );
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
