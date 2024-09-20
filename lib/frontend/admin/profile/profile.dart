// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/apiservice/adminApi/arepoimpl.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Student.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/frontend/authentication/AdminLogin.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/admin/profile/transaction.dart';
import 'package:use/frontend/student/profile/profile.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc(AdminRepositoryImpl());class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  bool isBook = false;
  StudentBagItem? itemCode;
  StudentBagBook? bookCode;
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _showItemDetailsDialog(BuildContext context, bool isBook, dynamic item) {
    final int id = item.id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isBook ? "Book Details" : "Item Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: isBook
                  ? [
                      Text("Book Name: ${item.bookName}"),
                      Text("Subject Code: ${item.subjectCode}"),
                      Text("Subject Description: ${item.subjectDesc}"),
                      Text("Status: ${item.status}"),
                      Text("Claiming Schedule: ${item.claimingSchedule}"),
                      Text("Reservation Number: ${item.reservationNumber}"),
                    ]
                  : [
                      Text("Course: ${item.course}"),
                      Text("Gender: ${item.gender}"),
                      Text("Type: ${item.type}"),
                      Text("Body: ${item.body}"),
                      Text("Size: ${item.size}"),
                      Text("Status: ${item.status}"),
                      Text("Claiming Schedule: ${item.claimingSchedule}"),
                      Text("Reservation Number: ${item.reservationNumber}"),
                    ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Proceed"),
              onPressed: () {
                if(isBook){
                  context.read<AdminExtendedBloc>().add(changeBookStatus(id, "complete"));
                }
                else{
                  context.read<AdminExtendedBloc>().add(changeItemStatus(id, "complete"));
                }
                
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    @override
    Widget build(BuildContext context) {
      return BlocProvider<AdminExtendedBloc>(
        create: (context) => AdminExtendedBloc(AdminRepositoryImpl()),
        child: BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
          listener: (context, state) {
            if (state is NotificationPageState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
            } else if (state is TransactionPageState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Transaction()));
            } else if (state is itemCodeDataLoaded) {
              setState(() {
                itemCode = state.studentBagItem;
              });
              if (itemCode != null) {
                _showItemDetailsDialog(context, false, itemCode);
              } else {
                print("itemCode is null");
              }
            } else if (state is bookCodeDataLoaded) {
              setState(() {
                bookCode = state.studentBagBook; 
              });
              if (bookCode != null) {
                _showItemDetailsDialog(context, true, bookCode);
              } else {
                print("bookCode is null");
              }
            }
          },
        builder: (context, state) {
          if (state is AdminLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 14, 170, 113)),
                  onPressed: () {
                    context.read<AdminExtendedBloc>().add(NotificationPageEvent());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Color.fromARGB(255, 14, 170, 113)),
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'Are you sure you wanna logout',
                            style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminLogin()));
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
                      },
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
                      decoration: BoxDecoration(color: Colors.white),
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            height: 1,
                            width: double.infinity,
                            child: Container(decoration: BoxDecoration(color: Colors.black26)),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Transaction',
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
                                    color: Colors.grey.shade400,
                                    blurRadius: 5,
                                    offset: Offset(1, 5),
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
                            'Pick-Up Code',
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Student product code for claiming',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 170, 113),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5,
                                  offset: Offset(1, 5),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Item', style: TextStyle(color: Colors.white)),
                                      Switch(
                                        value: isBook,
                                        onChanged: (value) {
                                          setState(() {
                                            isBook = value;
                                            print(isBook);
                                          });
                                        },
                                        activeColor: Colors.white,
                                      ),
                                      Text('Book', style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: codeController,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      hintText: 'ENTER CODE',
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                    onPressed: () {
                                      if (isBook) {
                                        context.read<AdminExtendedBloc>().add(showCodeBookData(codeController.text));
                                      } else {
                                        context.read<AdminExtendedBloc>().add(showCodeItemData(codeController.text));
                                      }
                                    },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Color(0xFF0EAA72),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        "Complete",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF0EAA72),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          ItemList(students: details),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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
              
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF0EAA72),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: Offset(1, 5),
                  ),
                ],
              ),
              child: Stack( 
                children: [
                  Positioned(
                    top: 15,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visual.studentName,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          visual.studentID,
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w400
                          ),
                        ),
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