// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/Department.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/frontend/student/home/course.dart';
import 'package:use/frontend/student/home/uniform.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/frontend/student/widgets/home/home.dart';

import '../../admin/home/stocks.dart';

final StudentExtendedBloc studBloc = StudentExtendedBloc();
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }
  
  @override 
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      bloc: studBloc,
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is BackpackPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Bag()));
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
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
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