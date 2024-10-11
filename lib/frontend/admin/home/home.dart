// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif(studentProfile: 0)));
        } else if (state is CoursePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Courses(departmentID: 0, departmentName: '',)));
        } else if (state is ManagePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => manage()));
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
                automaticallyImplyLeading: false,
                centerTitle: false,
                actions: <Widget>[
                  SizedBox(width: 15),
                ],
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Stack(
                children:[
                  ListView(
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
                                Text(
                                  'Departments',
                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Choose your perspective department for -',
                                  style: TextStyle(color: tertiary_color, fontSize: 10, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 20), 
                                ItemList (
                                  departments : state.departments,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5,
                    right: 23,
                    child: InkWell(
                      onTap:() {
                        adminBloc.add(NewDepartmentPageEvent());
                      },
                      child: Icon(
                        Icons.add,
                        color: primary_color,
                      ),
                    ),
                  ),
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
        }
        else{
          return Center(child: CircularProgressIndicator());
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
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
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
                    colors: [
                      primary_color,
                      Color.fromARGB(43, 14, 170, 113),
                    ],
                    stops: [0.50, 0.70],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 25.0,
                          left: 30.0
                      ),
                      child: Text(
                        visual.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30.0
                      ),
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 85,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Color.fromARGB(227, 255, 255, 255)
              ),
              child: InkWell(
                onTap: () {
                  adminBloc.add(ManagePageEvent());
                },
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Manage',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 10.5,
                            color: primary_color,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: primary_color,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}