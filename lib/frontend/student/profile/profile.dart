// ignore_for_file: prefer__ructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/notificationService/notificationService.dart';
import 'package:use/frontend/Authentication/StudentLogin.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/frontend/student/profile/books.dart';
import 'package:use/frontend/student/profile/transaction.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/frontend/student/profile/uniforms.dart';
import 'package:use/frontend/student/widgets/profile/uniform.dart';

import '../../colors/colors.dart';
import '../widgets/profile/book.dart';

final StudentExtendedBloc studBloc =
    StudentExtendedBloc(StudentRepositoryImpl());

class Profile extends StatefulWidget {
  Profile({super.key, required this.studentProfile});
  final StudentProfile studentProfile;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  int _currentSelection = 1;
  GlobalKey _Complete = GlobalKey();
  GlobalKey _Cancelled = GlobalKey();

  List<StudentBagItem> items = [];
  List<StudentBagBook> books = [];
  NotificationService? _notificationService;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    final bloc = context.read<StudentExtendedBloc>();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    bloc.add(studentBagItem(widget.studentProfile.id, "Complete"));
    bloc.add(studentBagBook(widget.studentProfile.id, "Complete"));
  }

  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
      String status = id == 1 ? "Complete" : "Cancelled";
      final bloc = context.read<StudentExtendedBloc>();
      bloc.add(studentBagItem(widget.studentProfile.id, status));
      bloc.add(studentBagBook(widget.studentProfile.id, status));
    });
  }

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
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        notif(studentProfile: widget.studentProfile)),
              );
              if (result == true) {
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagItem(widget.studentProfile.id, "Complete"));
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagBook(widget.studentProfile.id, "Complete"));
              } else {
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagBook(widget.studentProfile.id, "Complete"));
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagItem(widget.studentProfile.id, "Complete"));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.backpack, color: primary_color),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Bag(
                        studentProfile: widget.studentProfile,
                        Status: widget.studentProfile.status)),
              );
              if (result == true) {
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagItem(widget.studentProfile.id, "Complete"));
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagBook(widget.studentProfile.id, "Complete"));
              } else {
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagItem(widget.studentProfile.id, "Complete"));
                context
                    .read<StudentExtendedBloc>()
                    .add(studentBagBook(widget.studentProfile.id, "Complete"));
              }
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
                          _notificationService?.stopPolling();
                          final SharedPreferences logout =
                              await SharedPreferences.getInstance();
                          logout.clear();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StudnetLogin()),
                          );
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
                              'Continue',
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
                            color: Color.fromARGB(192, 14, 170, 113),
                          ),
                          child: Center(
                            child: Text(
                              'Nope',
                              style: TextStyle(
                                color: Color.fromARGB(190, 255, 255, 255),
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
      body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
        builder: (context, state) {
          if (_showLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is StudentBagCombinedLoadSuccessState) {
            items = state.studentBagItems;
            books = state.studentBagBooks;
          }
          switch (state.runtimeType) {
            case StudentLoadingState:
              return Center(child: CircularProgressIndicator());
            case StudentErrorState:
              return Center(child: Text('Error'));
            default:
              return ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 54,
                                  width: 54,
                                  decoration: BoxDecoration(
                                      color: primary_color,
                                      borderRadius: BorderRadius.circular(2)),
                                ),
                                VerticalDivider(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.studentProfile.firstName} ${widget.studentProfile.lastName}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Course: ${widget.studentProfile.course}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.studentProfile.stuId} | Year: ${widget.studentProfile.year} |",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${widget.studentProfile.status}',
                                          style: TextStyle(
                                            color: primary_color,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
                                      decoration:
                                          BoxDecoration(color: secondary_color),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                              height: 20,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Text(
                                      'Transaction',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                          height: 20,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'View Transaction >',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: tertiary_color,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primary_color,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5,
                                    offset: Offset(1, 4),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                padding: EdgeInsets.only(top: 5),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Transaction(
                                                        page: 1,
                                                        studentProfile: widget
                                                            .studentProfile,
                                                        status: 'Request')),
                                          );
                                          if (result == true) {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          } else {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Icon(
                                              Icons.request_page_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Request',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Transaction(
                                                        page: 2,
                                                        studentProfile: widget
                                                            .studentProfile,
                                                        status: 'Reserved')),
                                          );
                                          if (result == true) {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          } else {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          }
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
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Transaction(
                                                        page: 3,
                                                        studentProfile: widget
                                                            .studentProfile,
                                                        status: 'Claim')),
                                          );
                                          if (result == true) {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          } else {
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagBook(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                            context
                                                .read<StudentExtendedBloc>()
                                                .add(studentBagItem(
                                                    widget.studentProfile.id,
                                                    "Complete"));
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Icon(
                                              Icons.back_hand_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Claim',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
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
                              'History',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                InkWell(
                                  key: _Complete,
                                  onTap: () => _selectedItem(1),
                                  child: Text(
                                    'Complete',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: _currentSelection == 1
                                            ? primary_color
                                            : tertiary_color,
                                        fontWeight: _currentSelection == 1
                                            ? FontWeight.w500
                                            : FontWeight.w400),
                                  ),
                                ),
                                SizedBox(width: 15),
                                InkWell(
                                  key: _Cancelled,
                                  onTap: () => _selectedItem(2),
                                  child: Text(
                                    'Cancelled',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: _currentSelection == 2
                                            ? primary_color
                                            : tertiary_color,
                                        fontWeight: _currentSelection == 2
                                            ? FontWeight.w500
                                            : FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.black26),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 20,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Text(
                                      'Books',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Positioned(
                                    right: -5,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Books(
                                                  studentProfile:
                                                      widget.studentProfile)),
                                        );
                                      },
                                      child: Container(
                                          height: 20,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'View All Books >',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: tertiary_color,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 40),
                                child: FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: book_list(
                                    status: books
                                        .where((book) =>
                                            book.status ==
                                            (_currentSelection == 1
                                                ? "Complete"
                                                : "Cancelled"))
                                        .toList(),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                              height: 20,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Text(
                                      'Uniform',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Positioned(
                                    right: -5,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => uniforms(
                                                  studentProfile:
                                                      widget.studentProfile)),
                                        );
                                      },
                                      child: Container(
                                          height: 20,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'View All Uniform >',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: tertiary_color,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            uniform_list(
                              status: items
                                  .where((item) =>
                                      item.status ==
                                      (_currentSelection == 1
                                          ? "Complete"
                                          : "Cancelled"))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
