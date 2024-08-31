// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Department.dart';
import 'package:use/UI/Core/admin/home/course.dart';
import 'package:use/UI/Core/admin/home/management/manage.dart';
import 'package:use/UI/Core/admin/home/management/newDepartment.dart';
import 'package:use/UI/Core/admin/home/uniform.dart';
import 'package:use/UI/Core/admin/notification.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc();
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is CoursePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => courses()));
        } else if (state is NewDepartmentPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => newDepartment()));
        } else if (state is ManagePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => manage()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminLoadingState():
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
                      Icons.search, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      adminBloc.add(NotificationPageEvent());
                    },
                  ),
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
                                SizedBox(height: 20), 
                                ItemList(
                                  departments : initials
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 25,
                    right: 30,
                    child: InkWell(
                      onTap:() {
                        adminBloc.add(NewDepartmentPageEvent());
                      },
                      child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 14, 170, 113),
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      }
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Departments> departments;
  const ItemList({Key? key, required this.departments}) : super (key: key);
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
  final Departments visual;
  const ItemCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 50.0;
    final spacing = 10.0;
    final initialSpacing = 50.0;
    final availableWidth = screenWidth * 0.5 - initialSpacing;
    final itemsPerRow = (availableWidth / (itemWidth + spacing)).floor();
    return Container (
      margin: const EdgeInsets.only(
        bottom: 30.0,
      ),
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 170, 113),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(1, 8),
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
              child: Image.asset(
                visual.imageUrl,
                width: 220,
                height: 220, 
              ),
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                adminBloc.add(CoursePageEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 14, 170, 113),
                      Color.fromARGB(123, 14, 170, 113),
                    ],
                    stops: [0.50, 0.70],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                        left: 30.0
                      ),
                      child: Text(
                        visual.department,
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
                        top: 9.0,
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
                        top: 55.0,
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
            top: 46,
            left: 30,
            child: Container(
              width: screenWidth * 0.5,
              height: 40,
              child: Wrap(
                spacing: spacing, 
                runSpacing: spacing,
                alignment: WrapAlignment.start,
                children: [
                  SizedBox(width: 50),
                  ...List.generate(itemsPerRow * 2, (index) {
                    return Container(
                      width: itemWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(1, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          visual.courses,
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 14, 170, 113),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 30,
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
                          color: Color.fromARGB(255, 14, 170, 113),
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: Color.fromARGB(255, 14, 170, 113),
                      size: 15,
                    )
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