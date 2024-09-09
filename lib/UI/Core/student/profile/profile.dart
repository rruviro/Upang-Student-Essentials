// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/StudentData/StudentBagData/StudentBagBook.dart';
import 'package:use/SERVICES/model/StudentData/StudentBagData/StudentBagItem.dart';
import 'package:use/SERVICES/model/StudentData/StudentProfile.dart';
import 'package:use/SERVICES/model/student/History.dart';
import 'package:use/UI/Authentication/StudentLogin.dart';
import 'package:use/UI/Core/student/bag.dart';
import 'package:use/UI/Core/student/notification.dart';
import 'package:use/UI/Core/student/profile/transaction.dart';

final StudentExtendedBloc studBloc = StudentExtendedBloc();

class Profile extends StatefulWidget {
  const Profile({super.key, required this.studentProfile});
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

  bool _showLoading = true; 

  @override
  void initState() {
    super.initState();
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
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => notif(studentProfile: widget.studentProfile)),
              );
              if (result == true) {
                context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
              } else {
                context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.backpack, color: Color.fromARGB(255, 14, 170, 113)),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bag(studentProfile: widget.studentProfile, Status: widget.studentProfile.status)),
              );
              if (result == true) {
                context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
              } else {
                context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
              }
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
                      'Are you sure you wanna logout?',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => StudnetLogin()),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 112,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color.fromARGB(255, 14, 170, 113),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: GoogleFonts.inter(
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
                              style: GoogleFonts.inter(
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.studentProfile.firstName} ${widget.studentProfile.lastName}",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              widget.studentProfile.stuId,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black26),
                              ),
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
                                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: Offset(1, 8),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                padding: const EdgeInsets.only(top: 5),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Transaction(page: 1, studentProfile: widget.studentProfile, status: 'Request')),
                                          );
                                          if (result == true) {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                                          } else {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
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
                                              style: GoogleFonts.inter(
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
                                            MaterialPageRoute(builder: (context) => Transaction(page: 2, studentProfile: widget.studentProfile, status: 'Reserved')),
                                          );
                                          if (result == true) {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                                          } else {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
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
                                              style: GoogleFonts.inter(
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
                                            MaterialPageRoute(builder: (context) => Transaction(page: 3, studentProfile: widget.studentProfile, status: 'Claim')),
                                          );
                                          if (result == true) {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
                                          } else {
                                            context.read<StudentExtendedBloc>().add(studentBagBook(widget.studentProfile.id, "Complete"));
                                            context.read<StudentExtendedBloc>().add(studentBagItem(widget.studentProfile.id, "Complete"));
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
                                              style: GoogleFonts.inter(
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
                            Text(
                              'History',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                InkWell(
                                  key: _Complete,
                                  onTap: () => _selectedItem(1),
                                  child: Text(
                                    'Complete',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: _currentSelection == 1 ? Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  height: 25,
                                  width: 1,
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.black26),
                                  ),
                                ),
                                SizedBox(width: 20),
                                InkWell(
                                  key: _Cancelled,
                                  onTap: () => _selectedItem(2),
                                  child: Text(
                                    'Cancelled',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: _currentSelection == 2 ? Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black26),
                              ),
                            ),Text(
                              'Uniform',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            ItemList(
                              status: items.where((item) =>
                                item.status == (_currentSelection == 1 ? "Complete" : "Cancelled")
                              ).toList(),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Books',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            BookList(
                              status: books.where((book) =>
                                book.status == (_currentSelection == 1 ? "Complete" : "Cancelled")
                              ).toList(),
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


class ItemList extends StatelessWidget {
  final List<StudentBagItem> status;
  const ItemList({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map((e) => ItemCard(
                item: e,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final StudentBagItem item;
  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 14, 170, 113),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network("assets/b19d1b570a8d62ff56f4f351e389c2db.jpg"), // Placeholder for actual image
              ),
              SizedBox(width: 10),
              Stack(
                children: [
                  Positioned(
                    top: 55,
                    left: 0,
                    child: SizedBox(
                      height: 1,
                      width: 500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Department :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            item.department,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Code :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            item.code ?? 'N/A',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        item.status,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Claimed :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            item.dateReceived?.toLocal().toIso8601String() ?? 'N/A',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        title: Text(
                          'Details',
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Department: ${item.department}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Code: ${item.code ?? 'N/A'}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Type: ${item.type}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Body: ${item.body}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Size: ${item.size}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Status: ${item.status}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Date Received: ${item.dateReceived?.toLocal().toIso8601String() ?? 'N/A'}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  size: 15.0,
                  color: Color.fromARGB(255, 14, 170, 113),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BookList extends StatelessWidget {
  final List<StudentBagBook> status;
  const BookList({Key? key, required this.status}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
        .map((e) => BookCard(
            book: e,
          ))
        .toList(),
    );
  }
}

class BookCard extends StatelessWidget {
  final StudentBagBook book;
  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 14, 170, 113),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network("assets/b19d1b570a8d62ff56f4f351e389c2db.jpg"), // Placeholder for actual image
              ),
              SizedBox(width: 10),
              Stack(
                children: [
                  Positioned(
                    top: 55,
                    left: 0,
                    child: SizedBox(
                      height: 1,
                      width: 500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Book :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.bookName,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Code :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.code ?? 'N/A',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        book.status,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Claimed :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.dateReceived?.toLocal().toIso8601String() ?? 'N/A',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        title: Text(
                          'Details',
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book : ${book.bookName}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Subject Code : ${book.subjectCode ?? 'N/A'}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Subject Desc : ${book.subjectDesc}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Status: ${book.status}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Date Received: ${book.dateReceived?.toLocal().toIso8601String() ?? 'N/A'}',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  size: 15.0,
                  color: Color.fromARGB(255, 14, 170, 113),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

