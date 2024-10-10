import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/Course.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/home/stocks.dart';
import 'package:use/frontend/student/widgets/home/course.dart';

import '../../colors/colors.dart';

class courses extends StatefulWidget {
  final StudentProfile profile;
  final int departmentID;
  final String departmentName;

  const courses({Key? key, required this.departmentID, required this.departmentName, required this.profile}) : super(key: key);

  @override
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  late StudentExtendedBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    _studentBloc = context.read<StudentExtendedBloc>();
    _studentBloc.add(ShowCoursesEvent(departmentID: widget.departmentID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is StockPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stocks(courseID: 0, courseName: '', Department: '',profile: widget.profile)));
        }
      },
      builder: (context, state) {
        if (state is CoursesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CoursesLoadedState) {
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
                offset: const Offset(-15.0, 0.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Courses',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Department: ${widget.departmentName}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              child: ListView(
                children: [
                  CourseWidget(
                    courses: state.courses,
                    departmentName: widget.departmentName,
                    id: widget.departmentID,
                    studentBloc: _studentBloc, profile: widget.profile,
                  ),
                ],
              ),
            ),
          );
        } else if (state is CoursesErrorState) {
          return Center(child: Text(state.error));
        }
        return Container();
      },
    );
  }
}

class CourseWidget extends StatelessWidget {
  final List<Course> courses;
  final String departmentName;
  final int id;
  final StudentExtendedBloc studentBloc;
  final StudentProfile profile;

  const CourseWidget({
    Key? key,
    required this.courses,
    required this.departmentName,
    required this.id,
    required this.studentBloc, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: courses
          .map((course) => ItemCard(
                course: course,
                departmentName: departmentName,
                id: id,
                studentBloc: studentBloc, profile: profile,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Course course;
  final String departmentName;
  final int id;
  final StudentProfile profile;
  final StudentExtendedBloc studentBloc;

  const ItemCard({
    Key? key,
    required this.course,
    required this.departmentName,
    required this.id,
    required this.studentBloc, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Stocks(
                courseID: course.id,
                courseName: course.courseName,
                Department: departmentName,
                profile: this.profile
              ),
            ),
          );

          if (result == true) {
            studentBloc.add(ShowCoursesEvent(departmentID: id));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
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
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    course.courseDescription,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(
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