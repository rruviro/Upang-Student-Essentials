// ignore_for_file: prefer__ructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/widgets/profile/uniform.dart';

import '../../../backend/models/student/StudentBagData/StudentBagItem.dart';

class uniforms extends StatefulWidget {
  final StudentProfile studentProfile;
  const uniforms({super.key, required this.studentProfile});

  @override
  State<uniforms> createState() => _uniformsState();
}

class _uniformsState extends State<uniforms> {
  List<StudentBagItem> items = [];
  int _currentSelection = 1;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    context
        .read<StudentExtendedBloc>()
        .add(allstudentBagItem(widget.studentProfile.id, "Complete"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: const Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Transform.translate(
            offset: Offset(-15.0, 0.0),
            child: Text(
              'Uniform',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
            builder: (context, state) {
              if (_showLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is StudentBagItemLoadSuccessState) {
                items = state.studentBagItem;
              }
              return ListView(
                children: [
                  items.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height - 200, // Adjust the height as needed
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/empty_state/announcement.png",
                                height: 160,
                                width: 160,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'No announcements available',
                                style: TextStyle(fontSize: 10, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    : uniform_list(
                      status: items,
                    ),
                ],
              );
          }
        )
      )
    );
  }
}
