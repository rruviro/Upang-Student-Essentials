import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/Course.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/home/stocks.dart';
import 'package:use/frontend/student/widgets/home/course.dart';

void main() => runApp(MaterialApp(
  home: courses(),
));

class courses extends StatefulWidget {
  @override
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  String _selectedYear = "First Year";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      bloc: studBloc,
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is StockPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stocks()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case StudentLoadingState():
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
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Year',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 30,
                          height: 1,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: 100,
                            height: 20,
                            child: DropdownButton<String>(
                              value: _selectedYear,
                              dropdownColor: Color(0xFF0EAA72),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedYear = newValue!;
                                });
                              },
                              items: <String>[
                                'First Year',
                                'Second Year',
                                'Third Year',
                                'Fourth Year'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white, fontSize: 13),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                  icon: Icon(Icons.backpack_outlined, color: Colors.white),
                    onPressed: () {
                      studBloc.add(BackpackPageEvent());
                    },
                  ),
                  SizedBox(width: 15),
                ],
              ),
              body: ListView(
                children: [
                  SizedBox(height: 20),
                  course_widget (
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