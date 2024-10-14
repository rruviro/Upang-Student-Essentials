// ignore_for_file: prefer_const_constructors
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/frontend/student/widgets/announcement.dart';
import 'package:use/frontend/student/widgets/announcement.dart';

import '../../colors/colors.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key, required this.studentProfile});
  final StudentProfile studentProfile;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  
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
    context.read<StudentExtendedBloc>().add(showAnnouncementData(widget.studentProfile.department));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled){
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Announcement",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            )
          ];
        }, 
        body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
          builder: (context, state) {
              if (_showLoading) {
                return Center(child: Lottie.asset(
                  'assets/lottie/loading.json',
                  height: 300,
                  width: 380,
                  fit: BoxFit.fill
                ));
              }
              if (state is announcementLoadSuccessData) {
                announcements = state.Announcement;
                return Container(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          slides(context),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Announcement',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 5),
                                announcements.isEmpty
                                  ? Container(
                                      height: MediaQuery.of(context).size.height - 450, 
                                      width: double.infinity,
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
                                            // Text('', style: TextStyle(fontSize: 15, color: Colors.black)),
                                            Text('No announcements available', style: TextStyle(fontSize: 10, color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    )
                                  : announcement_list(
                                    status: announcements,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                );
              }
              if (state is announcementLoadErrorData) {
                return Center(child: Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                        color: primary_color,
                        size: 130,
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        'You\'r having trouble with your connection\ncheck your connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: tertiary_color,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    )
                  ],
                )
              ),);
              }
              else{
                return Center(child: Lottie.asset(
                  'assets/lottie/loading.json',
                  height: 300,
                  width: 380,
                  fit: BoxFit.fill
                ));
              }
          }
        )
      )
    );
  }
}

Widget slides(BuildContext context) {
  List<String> imageUrls = [
    'assets/announcement_image/e6cad8e6-4afa-4f35-a78e-2defea59f7e7.png',
    'assets/announcement_image/e9c4b145-4d7b-4787-bd61-7b38c4b3ba44.png',
    'assets/announcement_image/0d88f45a-60dc-4518-9641-6f318056db74.png',
  ];
  return Container(
    child: CarouselSlider(
      items: imageUrls.map((url) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: primary_color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 160,
        autoPlay: true, 
        autoPlayInterval: Duration(seconds: 3), 
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn, 
        enlargeCenterPage: true,
      ),
    ),
  );
}