// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< Updated upstream
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/student/Announcement.dart';
import 'package:use/frontend/admin/home/home.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/admin/widgets/announcement/announcement.dart';
=======
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/frontend/student/announcement/announcement.dart';

import '../../colors/colors.dart';
>>>>>>> Stashed changes

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
<<<<<<< Updated upstream
  final TextEditingController _controller = TextEditingController();
=======
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

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
<<<<<<< Updated upstream
        backgroundColor: Color.fromARGB(255, 14, 170, 113),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications, 
              color: Colors.white
            ),
            onPressed: () {
              adminBloc.add(NotificationPageEvent());
            },
          ),
          SizedBox(width: 15),
        ],
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
=======
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
            return Center(child: CircularProgressIndicator());
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
>>>>>>> Stashed changes
                      ),
                    ),
                    SizedBox(height: 10),
                    ItemList (
                      status : details
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
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
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                          ),
                          hintText: 'Department',
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
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                    ]
                  ),
                ),
                actions: [
                  GestureDetector(
<<<<<<< Updated upstream
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromARGB(255, 14, 170, 113)
                      ),
                      child: Center( 
                        child: Text(
                          'Publish',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600 
                          ),
=======
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
>>>>>>> Stashed changes
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromARGB(192, 14, 170, 113)
                      ),
                      child: Center(
                        child:Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(190, 255, 255, 255),
                            fontSize: 13,
                            fontWeight: FontWeight.w600 
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 14, 170, 113),
      ),
    );
  }
}

<<<<<<< Updated upstream
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
        autoPlay: false, 
        autoPlayInterval: Duration(seconds: 3), 
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn, 
        enlargeCenterPage: true,
      ),
    ),
  );
}

=======
>>>>>>> Stashed changes
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
                color: Colors.grey.shade400,
                blurRadius: 5,
                offset: Offset(1, 5),
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
                    horizontal: 10.0, vertical: 10.0),
                child: Text(
<<<<<<< Updated upstream
                  details.description,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 10
                  ),
=======
                  details.body,
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 10),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                details.published,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10
                ),
=======
                details.date,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
>>>>>>> Stashed changes
              ),
            ),
          ),
        ),
      ],
    );
  }
}