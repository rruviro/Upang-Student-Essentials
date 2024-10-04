// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/announcement/announcement.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/profile/profile.dart';

import '../colors/colors.dart';

class SHomeBase extends StatelessWidget {
  final String studentId;

  SHomeBase({required this.studentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentExtendedBloc>(
          create: (context) =>
              StudentExtendedBloc(StudentRepositoryImpl())..add(studentProfileGet(studentId)),
        ),
        BlocProvider<StudentBottomBloc>(
          create: (context) => StudentBottomBloc(),
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
  final String studentID;

  const HomeScreen({required this.studentID, Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _Homedestinationtate();
}

class _Homedestinationtate extends State<HomeScreen> {
  late StudentProfile studentProfile;
  bool isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    print(widget.studentID);
    print("herehre");
    context
        .read<StudentExtendedBloc>()
        .add(studentProfileGet(widget.studentID));
  }

  final itemsBN = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home_outlined, size: 20.0),
      title: const Text(
        'Home',
        style: TextStyle(fontSize: 10),
      ),
      activeIcon: Icon(Icons.home),
      unselectedColor: tertiary_color,
      selectedColor: primary_color,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.campaign_outlined, size: 20.0),
      title: const Text(
        'Announcement',
        style: TextStyle(fontSize: 10),
      ),
      activeIcon: Icon(Icons.campaign_rounded),
      unselectedColor: tertiary_color,
      selectedColor: primary_color,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person_outline_sharp, size: 20.0),
      title: const Text(
        'Profile',
        style: TextStyle(fontSize: 10),
      ),
      activeIcon: Icon(Icons.person),
      unselectedColor: tertiary_color,
      selectedColor: primary_color,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      listener: (context, state) {
        if (state is SpecificStudentLoadSuccessState) {
          setState(() {
            studentProfile = state.studentProfile;
            isProfileLoaded = true;
          });
          //context.read<StudentExtendedBloc>().add(studentBagItem(studentProfile.id,"Complete"));
        }
      },
      builder: (context, state) {
        final destination = [
          isProfileLoaded
              ? Home(studentProfile: studentProfile,)
              : Center(child: CircularProgressIndicator()),
          isProfileLoaded
              ? Announcement(studentProfile: studentProfile,)
              : Center(child: CircularProgressIndicator()),
          isProfileLoaded
              ? Profile(studentProfile: studentProfile)
              : Center(child: CircularProgressIndicator()),
        ];

        return BlocBuilder<StudentBottomBloc, StudentBottomState>(
          builder: (context, bottomState) {
            return Scaffold(
              body: destination.elementAt(bottomState.tabIndex),
              bottomNavigationBar: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Align(
                      heightFactor: 1.0,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 260.0),
                        child: SalomonBottomBar(
                          backgroundColor: Colors.white,
                          items: itemsBN,
                          currentIndex: bottomState.tabIndex,
                          duration: Duration(seconds: 1),
                          onTap: (index) {
                            BlocProvider.of<StudentBottomBloc>(context)
                                .add(TabChange(tabIndex: index));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
