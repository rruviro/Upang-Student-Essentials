// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/SERVICES/model/student/Department.dart';
import 'package:use/backend/notificationService/notificationService.dart';
import 'package:use/frontend/student/bag.dart';

import 'package:use/frontend/student/home/course.dart';
import 'package:use/frontend/student/home/uniform.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';

import '../../admin/home/stocks.dart';
import '../../colors/colors.dart';
import '../widgets/home/home.dart';

final StudentExtendedBloc studBloc = StudentExtendedBloc(StudentRepositoryImpl());
class Home extends StatefulWidget {
  final StudentProfile studentProfile;
  const Home({super.key, required this.studentProfile});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  NotificationService? _notificationService;
  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    _notificationService?.startPolling(widget.studentProfile.id);
  }
  
  @override 
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      bloc: studBloc,
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif(studentProfile: widget.studentProfile)));
        } else if (state is BackpackPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Bag(studentProfile: widget.studentProfile, Status: widget.studentProfile.status)));
        } else if (state is CoursePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => courses()));
        } else if (state is UniformPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case StudentLoadingState():
            return CircularProgressIndicator();
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Container(
                  width: double.infinity, 
                  height: 35, 
                  child: Row(
                    children: [
                      Image.asset('assets/logo.png'),
                      SizedBox(width: 10),
                      Text(
                        'Upang Student Essentials',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: false,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      studBloc.add(NotificationPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.backpack, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      studBloc.add(BackpackPageEvent());
                    },
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(-15.0, 0.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Departments',
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Choose your perspective department for -',
                                        style: TextStyle(color: tertiary_color, fontSize: 10, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ), 
                            // SizedBox(height: 20), 
                            // Container(
                            //   height: 50,
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     color: primary_color,
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            //   child: Center(
                            //     child: Row(
                            //       mainAxisSize: MainAxisSize.min,  
                            //       crossAxisAlignment: CrossAxisAlignment.center,  
                            //       children: [
                            //         Icon(
                            //           Icons.search, 
                            //           color: Colors.white,
                            //         ),
                            //         SizedBox(width: 10),  
                            //         Text(
                            //           "Search",
                            //           style: TextStyle(
                            //             fontSize: 13,
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 20), 
                            home_widget (
                              departments : initials
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}