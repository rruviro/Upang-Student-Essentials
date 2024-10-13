// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< Updated upstream
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Course.dart';
import 'package:use/frontend/admin/home/stocks.dart';
import 'package:use/frontend/admin/profile/profile.dart';
import 'package:use/frontend/admin/widgets/home/course.dart';
void main() => runApp(MaterialApp(
  home: courses(),
));
=======
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
>>>>>>> Stashed changes

class courses extends StatefulWidget {
  @override
<<<<<<< Updated upstream
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is StockPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stocks()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminLoadingState():
            return CircularProgressIndicator();
          default:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
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
                          'Course',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'Department: ',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
=======
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
                return Center(child: CircularProgressIndicator());
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
>>>>>>> Stashed changes
              ),
              body: ListView(
                children: [
                  SizedBox(height: 20),
                  course_widget(
                    status : details
                  )
                ],
              ),
            );
        }
      }
    );
  }
}