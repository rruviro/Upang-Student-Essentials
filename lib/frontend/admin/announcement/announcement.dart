// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/frontend/student/announcement/announcement.dart';

import '../../colors/colors.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final TextEditingController _messagecontroller = TextEditingController();
  String? _selectedDepartment;
  List<announcement> announcements = [];

  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    context.read<AdminExtendedBloc>().add(showAnnouncement());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      ),
      body: BlocBuilder<AdminExtendedBloc, AdminExtendedState>(
        builder: (context, state) {
          if (_showLoading) {
            return Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill));
          }

          if (state is announcementLoadSuccessData) {
            announcements = state.Announcement;
            return ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    slides(context),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Announcement',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          ItemList(
                            status: announcements,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          if (state is announcementLoadErrorData) {
            return Center(child: Text('Failed to load announcements.'));
          } else {
            return Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 300, width: 380, fit: BoxFit.fill));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                title: Text(
                  'New Announcement',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Container(
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedDepartment,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDepartment = newValue!;
                          });
                        },
                        items: [
                          'CITE',
                          'CAHS',
                          'CEA',
                          'CMA',
                          'CELA',
                          'CCJE',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primary_color),
                          ),
                          hintText: 'Select Department',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _messagecontroller,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primary_color),
                          ),
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (_selectedDepartment != null &&
                          _messagecontroller.text.isNotEmpty) {
                        context.read<AdminExtendedBloc>().add(
                              createAnnouncement(
                                _selectedDepartment!,
                                _messagecontroller.text,
                              ),
                            );

                        setState(() {
                          _selectedDepartment = null;
                          _messagecontroller.clear();
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all fields.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primary_color,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primary_color,
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<announcement> status;
  const ItemList({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map((e) => ItemCard(
                details: e,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final announcement details;
  const ItemCard({Key? key, required this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 15.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary_color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Text(
                  details.body,
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 10),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 26,
          left: 10,
          child: Container(
            child: Center(
              child: Text(
                details.department,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
        Positioned(
          top: 26,
          right: 10,
          child: Container(
            child: Center(
              child: Text(
                details.date,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
