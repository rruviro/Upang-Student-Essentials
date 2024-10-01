// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Student.dart';
import 'package:use/frontend/authentication/AdminLogin.dart';
import 'package:use/frontend/admin/notification.dart';
import 'package:use/frontend/admin/profile/transaction.dart';

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
                  IconButton(
                    icon: const Icon(
                      Icons.logout, 
                      color: Colors.white
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
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            content: Text(
                              'Are you sure you wanna logout',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400
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
                        }
                      );
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
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
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
                            SizedBox(height: 15),
                            Text(
                              'Transaction',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
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
                                            style: TextStyle(
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
                                            style: TextStyle(
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
                                            style: TextStyle(
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
                            SizedBox(height: 15),
                            Text(
                              'Pick-Up Code',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Student product code for claiming',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 14, 170, 113),
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
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'U3H1D',
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
                            SizedBox(height: 10),
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
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text(
                                          "Student Details",
                                          style: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 10,
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
                                      icon: Icon(Icons.add, color: Color.fromARGB(255, 14, 170, 113)),
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
              
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(138, 0, 0, 0).withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(1, 1),
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
                          "${visual.lastname}, ${visual.firstname}",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Course: ${visual.course}",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${visual.studentID} | Year: ${visual.year} |",
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              visual.enrolled ? 'Enrolled' : 'Not Enrolled',
                              style: GoogleFonts.inter(
                                color: visual.enrolled
                                    ? Color.fromARGB(255, 14, 170, 113)
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
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 14, 170, 113),
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
                            _showUpdate(context);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 170, 113),
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
                            _showDeleteDialog(context);
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
  String _selectedYear = 'First Year';
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
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Enter new student details',
                    style: GoogleFonts.inter(
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
          height: 300,
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
                              borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                              borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                        borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                  DropdownButtonFormField<String>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 'First Year', child: Text('First Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Second Year', child: Text('Second Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Third Year', child: Text('Third Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Fourth Year', child: Text('Fourth Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Fifth Year', child: Text('Fifth Year', style: GoogleFonts.inter(fontSize: 13))),
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
                      prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color.fromARGB(255, 14, 170, 113)),
                    ),
                    validator: (value) => value == null ? 'Year is required' : null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Enrolled', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
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
                          activeColor: Color.fromARGB(255, 14, 170, 113),
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 170, 113),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create',
                        style: GoogleFonts.inter(
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
  
void _showUpdate(BuildContext context) {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  String _selectedYear = 'First Year';
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
                    'Update Student',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Update Student details',
                    style: GoogleFonts.inter(
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
          height: 300,
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
                              borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                              borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                        borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
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
                  DropdownButtonFormField<String>(
                    value: _selectedYear,
                    items: [
                      DropdownMenuItem(value: 'First Year', child: Text('First Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Second Year', child: Text('Second Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Third Year', child: Text('Third Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Fourth Year', child: Text('Fourth Year', style: GoogleFonts.inter(fontSize: 13))),
                      DropdownMenuItem(value: 'Fifth Year', child: Text('Fifth Year', style: GoogleFonts.inter(fontSize: 13))),
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
                      prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color.fromARGB(255, 14, 170, 113)),
                    ),
                    validator: (value) => value == null ? 'Year is required' : null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Enrolled', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
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
                          activeColor: Color.fromARGB(255, 14, 170, 113),
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 170, 113),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create',
                        style: GoogleFonts.inter(
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

void _showDeleteDialog (BuildContext context) {
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
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              'Do you insist deleting Louise\'s details',
              style: GoogleFonts.inter(
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
                  'Yes',
                  style: GoogleFonts.inter(
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
                  style: GoogleFonts.inter(
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