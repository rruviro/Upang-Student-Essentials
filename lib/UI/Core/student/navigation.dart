// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:use/SERVICES/model/StudentData/StudentProfile.dart';
import 'package:use/UI/Core/student/announcement/announcement.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/UI/Core/student/home/home.dart';
import 'package:use/UI/Core/student/profile/profile.dart';

class HomeBase extends StatelessWidget {
  final String studentId;

  HomeBase({required this.studentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentExtendedBloc>(
          create: (context) =>
              StudentExtendedBloc()..add(studentProfileGet(studentId)),
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
  int _currentIndex = 0;
  late StudentProfile studentProfile;
  bool isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    print(widget.studentID);
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
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.campaign_outlined, size: 20.0),
      title: const Text(
        'Announcement',
        style: TextStyle(fontSize: 10),
      ),
      activeIcon: Icon(Icons.campaign_rounded),
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person_outline_sharp, size: 20.0),
      title: const Text(
        'Profile',
        style: TextStyle(fontSize: 10),
      ),
      activeIcon: Icon(Icons.person),
      unselectedColor: Colors.white60,
      selectedColor: Colors.white,
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
          Home(),
          Announcement(),
          isProfileLoaded
              ? Profile(studentProfile: studentProfile)
              : Center(child: CircularProgressIndicator()),
        ];

        return BlocBuilder<StudentBottomBloc, StudentBottomState>(
          builder: (context, bottomState) {
            return Scaffold(
              body: destination.elementAt(bottomState.tabIndex),
              bottomNavigationBar: Container(
                color: Color.fromARGB(255, 14, 170, 113),
                child: Stack(
                  children: <Widget>[
                    Align(
                      heightFactor: 1.0,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 260.0),
                        child: SalomonBottomBar(
                          backgroundColor: Color.fromARGB(255, 14, 170, 113),
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
