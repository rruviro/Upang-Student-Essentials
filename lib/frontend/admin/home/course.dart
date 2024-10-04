// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Course.dart';
import 'package:use/frontend/admin/home/stocks.dart';
import 'package:use/frontend/admin/profile/profile.dart';
import 'package:use/frontend/admin/widgets/home/course.dart';

import '../../colors/colors.dart';
void main() => runApp(MaterialApp(
  home: courses(),
));

class courses extends StatefulWidget {
  @override
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