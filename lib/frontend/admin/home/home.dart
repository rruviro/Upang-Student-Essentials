// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/apiservice/adminApi/arepoimpl.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Department.dart';
import 'package:use/frontend/admin/home/course.dart';
import 'package:use/frontend/admin/home/management/manage.dart';
import 'package:use/frontend/admin/home/uniform.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/student/home/course.dart';

import '../../../backend/models/admin/Department.dart';
import '../../colors/colors.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc(AdminRepositoryImpl());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    adminBloc.add(ShowDepartmentsEvent());

    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => notif(studentProfile: 0)));
        } else if (state is CoursePageState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Courses(
                        departmentID: 0,
                        departmentName: '',
                      )));
        } else if (state is ManagePageState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => manage()));
        }
      },
      builder: (context, state) {
        if (state is DepartmentsLoadingState) {
          return Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 300, width: 380, fit: BoxFit.fill));
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
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
              actions: <Widget>[
                SizedBox(width: 15),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Stack(
              children: [
                ListView(
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
                              Text(
                                'Departments',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Choose your perspective department for -',
                                style: TextStyle(
                                    color: tertiary_color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 20),
                              ItemList(
                                departments: state.departments,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Positioned(
                //   top: 5,
                //   right: 23,
                //   child: InkWell(
                //     onTap: () {
                //       adminBloc.add(NewDepartmentPageEvent());
                //     },
                //     child: Icon(
                //       Icons.add,
                //       color: primary_color,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        } else if (state is DepartmentsErrorState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(child: Text('Error: ${state.error}')),
          );
        } else {
          return Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 300, width: 380, fit: BoxFit.fill));
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List<department> departments;
  const ItemList({Key? key, required this.departments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: departments
          .map((e) => ItemCard(
                visual: e,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final department visual;
  const ItemCard({Key? key, required this.visual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 50.0;
    final spacing = 10.0;
    final initialSpacing = 50.0;
    final availableWidth = screenWidth * 0.5 - initialSpacing;
    final itemsPerRow = (availableWidth / (itemWidth + spacing)).floor();

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: primary_color, width: 2),
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
          // Department image
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
          // Department name and background
          Positioned.fill(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Courses(
                      departmentID: visual.id ?? 0,
                      departmentName: visual.name,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.white, Color.fromRGBO(11, 133, 214, 113)],
                    stops: [0.50, 0.70],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 30.0),
                  child: Text(
                    visual.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Information Row (Reserved, Claim, Complete)
          Positioned(
            bottom: 30, // Positioning the Row at the bottom of the container
            left: 30, // Adjust this value to align better if necessary
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Reserved: ${visual.reserved}  | ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  'Claim: ${visual.claim}  | ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  'Complete: ${visual.completed}',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
