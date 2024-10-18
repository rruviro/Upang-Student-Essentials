// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController DepartmentController = TextEditingController();
  final int maxLength = 25;
  int _countProd = 0;

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  
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

                // add button

                // Positioned(
                //   top: 5,
                //   right: 23,
                //   child: InkWell(
                //     onTap: () {
                //       _showAddDepartmentDialog();
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

  void _showAddDepartmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0),
          ),
          title: Container(
            height: 45,
            width: double.infinity,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'New Faculity Department',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Department Details',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          content: Container(
            height: 320,
            width: 200,
            child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _openImagePicker();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: primary_color,
                          borderRadius:
                              BorderRadius.circular(
                                  5)),
                      child: _image != null
                          ? Image.file(_image!,
                              fit: BoxFit.contain)
                          : Icon(
                              Icons
                                  .image_search_rounded,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller: DepartmentController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: primary_color),
                        ),
                        hintText: 'Department Name',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        suffix: Text(
                          '$_countProd/$maxLength',
                          style: TextStyle(
                            color: primary_color,
                            fontSize: 12,
                          ),
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller: DepartmentController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: primary_color),
                        ),
                        hintText: 'Course Acronym',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        suffix: Text(
                          '$_countProd/$maxLength',
                          style: TextStyle(
                            color: primary_color,
                            fontSize: 12,
                          ),
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller: DepartmentController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: primary_color),
                        ),
                        hintText: 'Course Name',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        suffix: Text(
                          '$_countProd/$maxLength',
                          style: TextStyle(
                            color: primary_color,
                            fontSize: 12,
                          ),
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),
                ]
              ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 112,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(2),
                    color: primary_color),
                child: Center(
                  child: Text(
                    'Deploy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600),
                    ),
                  )),
            ),
          ],
        );
      }
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
          // Adjusted Department image to move further right
          Positioned(
            right: -40, // it Adjust the IMAGE
            top: -35,
            child: Container(
              child: Image.network(
                visual.photoUrl,
                width: 220,
                height: 220,
              ),
            ),
          ),
          
          // Adjusted Gradient background to move further right
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
                    stops: [0.55, 0.90],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20.0),
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

          Positioned(
            bottom: 30,
            left: 20,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Reserved: ${visual.reserved}  | ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 8.5,
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
                      fontSize: 8.5,
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
                      fontSize: 8.5,
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
