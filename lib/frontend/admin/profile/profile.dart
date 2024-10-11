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

final AdminExtendedBloc adminBloc = AdminExtendedBloc(AdminRepositoryImpl());

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  bool isBook = false;
  bool isDialogOpen = false; // New flag to track if a dialog is open
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
    if (isDialogOpen) return;

    final int id = item.id;
    isDialogOpen = true;

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
                isDialogOpen = false;
                Navigator.of(context).pop();
                context.read<AdminExtendedBloc>().add(getStudent());
              },
            ),
            TextButton(
              child: Text("Proceed"),
              onPressed: () {
                if (isBook) {
                  context
                      .read<AdminExtendedBloc>()
                      .add(changeBookStatus(id, "Complete"));
                } else {
                  context
                      .read<AdminExtendedBloc>()
                      .add(changeItemStatus(id, "Complete"));
                }
                // Clear variables and close the dialog
                itemCode = null;
                bookCode = null;
                codeController.clear();
                isDialogOpen = false;
                Navigator.of(context).pop();

                // Show the success dialog
                _showSuccessDialog(context);
                context.read<AdminExtendedBloc>().add(getStudent());
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Successfully Claimed!"),
        );
      },
    );

    // Close the success dialog after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      listener: (context, state) {
        if (state is itemCodeDataLoaded) {
          setState(() {
            itemCode = state.studentBagItem;
          });
          if (itemCode != null && !isDialogOpen) {
            _showItemDetailsDialog(context, false, itemCode);
          } else {
            print("itemCode is null");
          }
        } else if (state is itemCodeDataError || state is bookCodeDataError) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('No code found.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else if (state is bookCodeDataLoaded) {
          setState(() {
            bookCode = state.studentBagBook;
          });
        } else if (state is studentLoaded) {
          setState(() {
            student = state.students;
          });
        } else if (state is studentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred!'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (bookCode != null && !isDialogOpen) {
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
        } else if (state is studentLoading) {
          print(state);
          return Center(child: CircularProgressIndicator());
        } else if (state is studentLoaded) {
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
                            'Are you sure you wanna logout?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AdminLogin()));
                              },
                              child: Container(
                                height: 30,
                                width: 112,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: primary_color,
                                ),
                                child: Center(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                    borderRadius: BorderRadius.circular(2),
                                    color: primary_color),
                                child: Center(
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
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
                            'Hello Admin',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
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
                                    decoration:
                                        BoxDecoration(color: secondary_color),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20),
                          Text(
                            'Pick-Up Code',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Student product code for claiming',
                            style: TextStyle(
                                fontSize: 10,
                                color: tertiary_color,
                                fontWeight: FontWeight.w400),
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
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
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(5),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        color: Colors.white,
                                        width: 1,
                                        height: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Item',
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                      Text('Book',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (isBook) {
                                          context.read<AdminExtendedBloc>().add(
                                              showCodeBookData(
                                                  codeController.text));
                                          print(codeController.text);
                                        } else {
                                          print(codeController.text);
                                          context.read<AdminExtendedBloc>().add(
                                              showCodeItemData(
                                                  codeController.text));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    decoration:
                                        BoxDecoration(color: secondary_color),
                                  ),
                                ),
                              )),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Overview",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text("Student Details",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: tertiary_color,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    )),
                                Positioned(
                                  top: 3,
                                  right: 0,
                                  child: IconButton(
                                      iconSize: 15,
                                      icon:
                                          Icon(Icons.add, color: primary_color),
                                      onPressed: () {
                                        _showCreateDialog(context);
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ItemList(students: student)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          print(state);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List<StudentProfile> students;
  const ItemList({Key? key, required this.students}) : super(key: key);
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
  const ItemCard({Key? key, required this.visual}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 15.0,
          ),
          child: InkWell(
            onTap: () {},
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
                                    : Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
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
                            _showUpdate(
                                context,
                                visual.firstName,
                                visual.lastName,
                                visual.course,
                                visual.department,
                                visual.year,
                                visual.status,
                                visual.id);
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
                            _showDeleteDialog(context, visual.id);
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
  int _selectedYear = 1;
  bool _isEnrolled = true;

  // Department and courses data
  Map<String, List<String>> departmentCourses = {
    'CITE': ['BSIT'],
    'CEA': ['BSCE', 'BSCPE', 'BSECE'],
    'CAHS': ['BSN', 'BSMLS', 'BSPHARMA', 'BSPSYCH'],
    'CMA': ['BSA', 'BST', 'BSHM'],
    'CELA': ['BSED', 'BSPOLSCI'],
    'CCJE': ['BSCRIM'],
  };

  String? selectedDepartment;
  String? selectedCourse;
  final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]*$');
  // Helper function to capitalize text
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

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
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                20), // Limit to 20 characters
                            FilteringTextInputFormatter.allow(RegExp(
                                r'^[a-zA-Z\s]*$')), // Allow only letters and spaces
                          ],
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
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                20), // Limit to 20 characters
                            FilteringTextInputFormatter.allow(RegExp(
                                r'^[a-zA-Z\s]*$')), // Allow only letters and spaces
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                  // Department Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    hint: Text('Select Department'),
                    items: departmentCourses.keys.map((String department) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                        selectedCourse =
                            null; // Reset course when department changes
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.school_outlined, color: Colors.blue),
                      labelText: 'Department',
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Course Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedCourse,
                    hint: Text('Select Course'),
                    items: selectedDepartment == null
                        ? []
                        : departmentCourses[selectedDepartment!]!
                            .map((String course) {
                            return DropdownMenuItem<String>(
                              value: course,
                              child: Text(course),
                            );
                          }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCourse = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Course',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(Icons.book_outlined, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Year Dropdown
                  DropdownButtonFormField<int>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 1, child: Text('First Year')),
                      DropdownMenuItem(value: 2, child: Text('Second Year')),
                      DropdownMenuItem(value: 3, child: Text('Third Year')),
                      DropdownMenuItem(value: 4, child: Text('Fourth Year')),
                      DropdownMenuItem(value: 5, child: Text('Fifth Year')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Year',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Enrolled',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                      Spacer(),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _isEnrolled,
                          onChanged: (value) {
                            setState(() {
                              _isEnrolled = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedDepartment == null ||
                          selectedCourse == null ||
                          _firstNameController.text.isEmpty ||
                          _lastNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please select Department and Course")),
                        );
                      } else {
                        context.read<AdminExtendedBloc>().add(
                              createStudent(
                                capitalizeFirstLetter(
                                    _firstNameController.text),
                                capitalizeFirstLetter(_lastNameController.text),
                                selectedCourse.toString(),
                                _selectedYear,
                                _isEnrolled ? "ACTIVE" : "INACTIVE",
                                selectedDepartment.toString(),
                              ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                          fontSize: 15,
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

void _showUpdate(BuildContext context, String firstname, String lastname,
    String course, String department, int year, String enrolled, int id) {
  final TextEditingController _firstNameController =
      TextEditingController(text: firstname);
  final TextEditingController _lastNameController =
      TextEditingController(text: lastname);

  int _selectedYear = year;
  bool _isEnrolled = enrolled == 'ACTIVE';

  // Map to hold the departments and their respective courses
  Map<String, List<String>> departmentCourses = {
    'CITE': ['BSIT'],
    'CEA': ['BSCE', 'BSCPE', 'BSECE'],
    'CAHS': ['BSN', 'BSMLS', 'BSPHARMA', 'BSPSYCH'],
    'CMA': ['BSA', 'BST', 'BSHM'],
    'CELA': ['BSED', 'BSPOLSCI'],
    'CCJE': ['BSCRIM'],
  };

  // Initialize the selected department and course variables
  String _selectedDepartment = department;
  List<String> _availableCourses = departmentCourses[_selectedDepartment]!;
  String _selectedCourse = course;

  final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]*$');
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

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
                  // First Name and Last Name input fields
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
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(onlyLetters),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
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
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(onlyLetters),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Dropdown for selecting Department
                  DropdownButtonFormField<String>(
                    value: _selectedDepartment,
                    items: departmentCourses.keys
                        .map((dep) => DropdownMenuItem(
                              value: dep,
                              child: Text(dep, style: TextStyle(fontSize: 13)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartment = value!;
                        _availableCourses =
                            departmentCourses[_selectedDepartment]!;
                        _selectedCourse =
                            _availableCourses[0]; // Reset course selection
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.school_outlined, color: Colors.blue),
                      labelText: 'Department',
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Dropdown for selecting Course
                  DropdownButtonFormField<String>(
                    value: _selectedCourse,
                    items: _availableCourses
                        .map((course) => DropdownMenuItem(
                              value: course,
                              child:
                                  Text(course, style: TextStyle(fontSize: 13)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCourse = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Course',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(Icons.book_outlined, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Year Dropdown
                  DropdownButtonFormField<int>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 1, child: Text('First Year')),
                      DropdownMenuItem(value: 2, child: Text('Second Year')),
                      DropdownMenuItem(value: 3, child: Text('Third Year')),
                      DropdownMenuItem(value: 4, child: Text('Fourth Year')),
                      DropdownMenuItem(value: 5, child: Text('Fifth Year')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Year',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Toggle switch for Enrolled status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enrolled:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Switch(
                        value: _isEnrolled,
                        onChanged: (value) {
                          setState(() {
                            _isEnrolled = value;
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Update Button
                  ElevatedButton(
                    onPressed: () {
                      if (_firstNameController.text.isEmpty ||
                          _lastNameController.text.isEmpty ||
                          _selectedCourse.isEmpty ||
                          _selectedDepartment.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("All fields must be filled correctly!"),
                          ),
                        );
                      } else {
                        // Trigger update event
                        context.read<AdminExtendedBloc>().add(
                              updateStudent(
                                capitalizeFirstLetter(
                                    _firstNameController.text),
                                capitalizeFirstLetter(_lastNameController.text),
                                _selectedCourse.toUpperCase(),
                                _selectedYear,
                                _isEnrolled ? "ACTIVE" : "INACTIVE",
                                id,
                                _selectedDepartment.toUpperCase(),
                              ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                          fontSize: 12,
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

void _showDeleteDialog(BuildContext context, int id) {
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
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Do you insist deleting this Student?',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                context.read<AdminExtendedBloc>().add(deleteStudent(id));
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: primary_color),
                child: Center(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
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
                    borderRadius: BorderRadius.circular(2),
                    color: Color.fromARGB(190, 14, 170, 113),
                  ),
                  child: Center(
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ],
        );
      });
}
