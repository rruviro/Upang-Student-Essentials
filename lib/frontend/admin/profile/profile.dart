// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/apiservice/adminApi/arepoimpl.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/authentication/AdminLogin.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/admin/profile/transaction.dart';
import 'package:use/frontend/student/profile/profile.dart';

import '../../../backend/models/admin/Student.dart';
import '../../colors/colors.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc(AdminRepositoryImpl());class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  bool isBook = false;
  StudentBagItem? itemCode;
  StudentBagBook? bookCode;
  TextEditingController codeController = TextEditingController();
  List<StudentProfile> student = [];
  bool _showLoading = true; 
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    print("showStudentProfileData");
    context.read<AdminExtendedBloc>().add(getStudent());
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
                  context.read<AdminExtendedBloc>().add(changeBookStatus(id, "Complete"));
                }
                else{
                  context.read<AdminExtendedBloc>().add(changeItemStatus(id, "Complete"));
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
        return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
          listener: (context, state) {
            if (state is itemCodeDataLoaded) {
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
            } else if (state is studentLoaded) {
              setState(() {
                student = state.students;
              });
            }
            if (bookCode != null) {
                _showItemDetailsDialog(context, true, bookCode);
              } else {
                print("bookCode is null");
              }
          },
        builder: (context, state) {
          if (_showLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AdminLoadingState) {
            print(state);
            return Center(child: CircularProgressIndicator());
          }
          else if (state is studentLoading){
            print(state);
            return Center(child: CircularProgressIndicator());
          }
          else if (state is studentLoaded) {
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
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications, color: primary_color),
                  onPressed: () {
                    context.read<AdminExtendedBloc>().add(NotificationPageEvent());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.logout, color: primary_color),
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'Are you sure you wanna logout',
                            style: TextStyle(
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
                                          style: TextStyle(
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
                                          style: TextStyle(
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
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TANGINA MO JEPOY DIZON, BETLOG MO PARANG JOLENS',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 1.2,
                                child: SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(color: secondary_color),
                                  ),
                                ),
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Pick-Up Code',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Student product code for claiming',
                              style: TextStyle(
                                fontSize: 10,
                                color: tertiary_color,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: primary_color,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Wrap TextFormField with Flexible to allow it to resize dynamically
                                        Flexible(
                                          child: TextFormField(
                                            controller: codeController,
                                            decoration: InputDecoration(
                                              hintText: 'ENTER THE CODE',
                                              hintStyle: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              hoverColor: Colors.white,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white), // Color when unfocused
                                              )
                                            ),
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.done,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: Colors.white,
                                          width: 1,
                                          height: 30,
                                        ),
                                        SizedBox(width: 10),
                                        Text('Item', style: TextStyle(color: Colors.white)),
                                        Transform.scale(
                                          scale: 0.8, 
                                          child: Switch(
                                            value: isBook,
                                            onChanged: (value) {
                                              setState(() {
                                                isBook = value;
                                              });
                                            },
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                        Text('Book', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),

                                    SizedBox(height: 15),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (isBook) {
                                            context.read<AdminExtendedBloc>().add(showCodeBookData(codeController.text));
                                            print(codeController.text);
                                          } else {
                                            print(codeController.text);
                                            context.read<AdminExtendedBloc>().add(showCodeItemData(codeController.text));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.white,
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
                            Container(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 1.2,
                                child: SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(color: secondary_color),
                                  ),
                                ),
                              )
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Overview",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text(
                                          "Student Details",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: tertiary_color,
                                            fontWeight: FontWeight.w400
                                          )
                                        ),
                                      ],
                                    )
                                  ),
                                  Positioned(
                                    top: 3,
                                    right: 0,
                                    child: IconButton(
                                      iconSize: 15,
                                      icon: Icon(Icons.add, color: primary_color),
                                      onPressed: (){
                                        _showCreateDialog(context);
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            ItemList(
                              students : student
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          );
          } else if(state is studentError){
            print(state);
            return Center(child: Text(state.error));
          }
          else{
            print(state);
            return Center(child: Text(state.toString()));
          }
        },
      );
  }
}

class ItemList extends StatelessWidget {
  final List<StudentProfile> students;
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
  final StudentProfile visual;
  const ItemCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 15.0,
          ),
          child: InkWell(
            onTap: () {
              
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Stack( 
                children: [
                  Positioned(
                    top: 20,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${visual.lastName}, ${visual.firstName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Course: ${visual.course}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${visual.stuId} | Year: ${visual.year} |",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Status: ${visual.status}",
                              style: TextStyle(
                                color: visual.status == 'ACTIVE'
                                  ? primary_color
                                    : Colors.red
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 10,
                      decoration: BoxDecoration(
                        color: primary_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showUpdate(context, visual.firstName, visual.lastName, visual.course, visual.department, visual.year, visual.status, visual.id);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: primary_color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_outward_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _showDeleteDialog(context,visual.id );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 67, 58),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
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

void _showCreateDialog(BuildContext context) {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
    final TextEditingController _departmentController = TextEditingController();
  int _selectedYear = 1;
  bool _isEnrolled = true;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(Icons.drive_folder_upload_outlined),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Student',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Enter new student details',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        content: Container(
          height: 400,
          width: double.infinity,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary_color),
                            ),
                            hintText: 'First Name',
                            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                          validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary_color),
                            ),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _courseController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      hintText: 'Course',
                      hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _departmentController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      hintText: 'Department',
                      hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 1, child: Text('First Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 2, child: Text('Second Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 3, child: Text('Third Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 4, child: Text('Fourth Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 5, child: Text('Fifth Year', style: TextStyle(fontSize: 13))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Year',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(Icons.calendar_month_outlined, color: primary_color),
                    ),
                    validator: (value) => value == null ? 'Year is required' : null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Enrolled', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _isEnrolled,
                          onChanged: (value) {
                            setState(() {
                              _isEnrolled = value;
                              print("Switch is now: $_isEnrolled");
                            });
                          },
                          activeColor: primary_color,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AdminExtendedBloc>().add(
                        createStudent(
                          _firstNameController.text,
                          _lastNameController.text,
                          _courseController.text,
                          _selectedYear,
                          _isEnrolled ? "ACTIVE" : "INACTIVE",
                          _departmentController.text,
                        ),
                      );

                      // Show the Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Student created successfully!"),
                          duration: Duration(seconds: 3),
                        ),
                      );

                      // Navigate back after showing the Snackbar
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_color,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );

}
  
void _showUpdate(BuildContext context, String firstname, String lastname, String course, String department, int year, String enrolled, int id) {
final TextEditingController _firstNameController = TextEditingController(text: firstname);
  final TextEditingController _lastNameController = TextEditingController(text: lastname);
  final TextEditingController _courseController = TextEditingController(text: course);
  final TextEditingController _departmentController = TextEditingController(text: department);
  int _selectedYear = year;
  bool _isEnrolled = enrolled == 'ACTIVE' ? true : false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(Icons.drive_folder_upload_outlined),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update Student',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Update Student details',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        content: Container(
          height: 400,
          width: double.infinity,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary_color),
                            ),
                            hintText: 'First Name',
                            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                          validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary_color),
                            ),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _departmentController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      hintText: 'Department',
                      hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _courseController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary_color),
                      ),
                      hintText: 'Course',
                      hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 1, child: Text('First Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 2, child: Text('Second Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 3, child: Text('Third Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 4, child: Text('Fourth Year', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 5, child: Text('Fifth Year', style: TextStyle(fontSize: 13))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Year',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(Icons.calendar_month_outlined, color: primary_color),
                    ),
                    validator: (value) => value == null ? 'Year is required' : null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Enrolled', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _isEnrolled,
                          onChanged: (value) {
                            setState(() {
                              _isEnrolled = value;
                              print("Switch is now: $_isEnrolled");
                            });
                          },
                          activeColor: primary_color,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AdminExtendedBloc>().add(
                        updateStudent(
                          _firstNameController.text,
                          _lastNameController.text,
                          _courseController.text,
                          _selectedYear,
                          _isEnrolled ? "ACTIVE" : "INACTIVE",
                          id,
                          _departmentController.text,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_color,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );

}

void _showDeleteDialog (BuildContext context, int id) {
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              'Do you insist deleting this Student?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              context.read<AdminExtendedBloc>().add(deleteStudent(id));
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: primary_color
              ),
              child: Center( 
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600 
                  ),
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
                color: Color.fromARGB(190, 14, 170, 113),
              ),
              child: Center(
                child:Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600 
                  ),
                ),
              )
            ),
          ),
        ],
      );
    }
  );

}