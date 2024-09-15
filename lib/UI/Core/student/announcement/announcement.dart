// ignore_for_file: prefer_const_constructors
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/StudentData/StudentProfile.dart';
import 'package:use/SERVICES/model/student/Announcement.dart';
import 'package:use/UI/Core/student/bag.dart';
import 'package:use/UI/Core/student/home/home.dart';
import 'package:use/UI/Core/student/notification.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key, required this.studentProfile});
  final StudentProfile studentProfile;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
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
              Icons.notifications, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<StudentExtendedBloc>.value(
                    value: studBloc,
                    child: notif(studentProfile: widget.studentProfile),
                  ),
                )
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.backpack, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<StudentExtendedBloc>.value(
                    value: studBloc,
                    child: Bag(studentProfile: widget.studentProfile, Status: widget.studentProfile.status),
                  ),
                )
              );
            },
          ),
          SizedBox(width: 15),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
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
                    SizedBox(height: 30),
                    Text(
                      'Announcement',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    ItemList(
                      status : details
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
            color: Color.fromARGB(255, 14, 170, 113),
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
        height: 140,
        autoPlay: true, 
        autoPlayInterval: Duration(seconds: 3), 
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn, 
        enlargeCenterPage: true,
      ),
    ),
  );
}

class ItemList extends StatelessWidget {
  final List<announcement> status;
  const ItemList({Key? key, required this.status}) : super (key: key);
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
  const ItemCard({Key? key, required this.details}) : super (key: key);
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
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
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
                  color: Color.fromARGB(255, 14, 170, 113),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0
                ),
                child: Text(
                  details.description,
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 10
                  ),
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
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10
                ),
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
                details.published,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}