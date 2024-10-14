// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Course.dart';
import '../../colors/colors.dart';
import 'stocks.dart';

class Courses extends StatelessWidget {
  final int departmentID;
  final String departmentName;

  const Courses(
      {Key? key, required this.departmentID, required this.departmentName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdminExtendedBloc>(context)
        .add(ShowCoursesEvent(departmentID: departmentID));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary_color,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Transform.translate(
            offset: Offset(-15.0, 0.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courses',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Department: $departmentName',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: BlocBuilder<AdminExtendedBloc, AdminExtendedState>(
            builder: (context, state) {
              if (state is CoursesLoadingState) {
                return Center(
                    child: Lottie.asset('assets/lottie/loading.json',
                        height: 300, width: 380, fit: BoxFit.fill));
              } else if (state is CoursesLoadedState) {
                return ListView(
                  children: state.courses
                      .map((course) => ItemCard(
                            course: course,
                            departmentName: departmentName,
                            departmentId: departmentID,
                          ))
                      .toList(),
                );
              } else if (state is CoursesErrorState) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return Container();
            },
          ),
        ));
  }
}

class ItemCard extends StatelessWidget {
  final Course course;
  final String departmentName;
  final int departmentId;

  const ItemCard(
      {Key? key,
      required this.course,
      required this.departmentName,
      required this.departmentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Stocks(
                courseID: course.id,
                courseName: course.courseName,
                Department: departmentName,
                departmentId: departmentId,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          height: 70,
          decoration: BoxDecoration(
            color: primary_color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Text(
                    course.courseName,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    course.courseDescription,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
