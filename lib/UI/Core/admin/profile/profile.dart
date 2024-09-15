// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Student.dart';
import 'package:use/UI/Authentication/AdminLogin.dart';
import 'package:use/UI/Core/admin/notification.dart';
import 'package:use/UI/Core/admin/profile/transaction.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc();
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
  
class _ProfileScreenState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is TransactionPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Transaction()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminLoadingState():
            return CircularProgressIndicator();
          default:
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
                      adminBloc.add(NotificationPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            title: Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            content: Text(
                              'Are you sure you wanna logout',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AdminLogin(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Color.fromARGB(255, 14, 170, 113),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Continue',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Color.fromARGB(192, 14, 170, 113),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Close',
                                            style: GoogleFonts.inter(
                                              color: Color.fromARGB(190, 255, 255, 255),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
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
                              'Ramon Montenegro',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            Text(
                              '01-1234-432154',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Transaction',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 14, 170, 113),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: Offset(1, 8),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        adminBloc.add(TransactionPageEvent());
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 13),
                                          Icon(
                                            Icons.approval,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Approval',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    InkWell(
                                      onTap: () {
                                        adminBloc.add(TransactionPageEvent());
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 13),
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Reserved',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    InkWell(
                                      onTap: () {
                                        adminBloc.add(TransactionPageEvent());
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 13),
                                          Icon(
                                            Icons.pending_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Pending',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    InkWell(
                                      onTap: () {
                                        adminBloc.add(TransactionPageEvent());
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 13),
                                          Icon(
                                            Icons.check_box_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Complete',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Student Details',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 20),
                            ItemList(
                              students : details
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
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Students> students;
  const ItemList({Key? key, required this.students}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: students
        .map((e) => ItemCard(
            visual: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Students visual;
  const ItemCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom: 13
          ),
          child: InkWell(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Stocks())); 
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF0EAA72),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(1, 8),
                  ),
                ],
              ),
              child: Stack( 
                children: [
                  Positioned(
                    top: 17,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visual.studentID,
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          visual.studentName,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 60,
                    child: SizedBox(
                      height: 70,
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    right: 20,
                    child: Icon(
                      Icons.arrow_forward_ios, 
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}