// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/SERVICES/model/student/Department.dart';
import 'package:use/backend/notificationService/notificationService.dart';
import 'package:use/frontend/admin/home/course.dart';
import 'package:use/frontend/admin/home/uniform.dart';
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
    // Trigger fetching of departments
    studBloc.add(ShowDepartmentsEvent());
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('course', widget.studentProfile.course);
    await pref.setInt('stubagid', widget.studentProfile.id);
    print(pref.getString('course'));
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => courses(departmentID: 0, departmentName: '', profile: widget.studentProfile,))
          );
        }
      },
      builder: (context, state) {
        if (state is DepartmentsLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DepartmentsLoadedState) {
          
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
                  icon: Icon(Icons.notifications, color: primary_color),
                  onPressed: () {
                    studBloc.add(NotificationPageEvent());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.backpack, color: primary_color),
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
                      decoration: BoxDecoration(color: Colors.white),
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
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          home_widget(departments: state.departments, profile: widget.studentProfile,), 
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is DepartmentsErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }
}

class home_widget extends StatelessWidget {
  final List<department> departments;
  final StudentProfile profile;
  const home_widget({Key? key, required this.departments, required this.profile}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: departments
          .map((e) => ItemCard(visual: e, profile: this.profile,))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final department visual;
  final StudentProfile profile;
  const ItemCard({Key? key, required this.visual, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => courses(
              departmentID: visual.id ?? 0,
              departmentName: visual.name,
              profile: this.profile,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        height: 80,
        decoration: BoxDecoration(
          color: primary_color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -35,
              child: Container(
                child: Image.network(
                  visual.photoUrl,
                  width: 220,
                  height: 220,
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25.0, left: 30.0),
                      child: Text(
                        visual.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
