// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';

class Transaction extends StatefulWidget {
  const Transaction(
      {super.key,
      required this.page,
      required this.studentProfile,
      required this.status});
  final StudentProfile studentProfile;
  final int page;
  final String status;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  late int _currentSelection;
  List<StudentBagItem> items = [];
  List<StudentBagBook> books = [];

  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.page;
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    context
        .read<StudentExtendedBloc>()
        .add(studentBagItem(widget.studentProfile.id, widget.status));
    context
        .read<StudentExtendedBloc>()
        .add(studentBagBook(widget.studentProfile.id, widget.status));
  }

  Future<bool> _onPop() async {
    Navigator.pop(context, true);
    return true;
  }

  final GlobalKey _requestKey = GlobalKey();
  final GlobalKey _reservedKey = GlobalKey();
  final GlobalKey _claimKey = GlobalKey();

  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
      String status;
      switch (id) {
        case 1:
          status = "Request";
          break;
        case 2:
          status = "Reserved";
          break;
        case 3:
          status = "Claim";
          break;
        default:
          status = "Request";
      }
      context
          .read<StudentExtendedBloc>()
          .add(studentBagItem(widget.studentProfile.id, status));
      context
          .read<StudentExtendedBloc>()
          .add(studentBagBook(widget.studentProfile.id, status));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: const Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Transform.translate(
            offset: Offset(-15.0, 0.0),
            child: Text(
              'Transaction',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: AppBar(
              toolbarHeight: 35,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        key: _requestKey,
                        onTap: () => _selectedItem(1),
                        child: Text(
                          'Request',
                          style: TextStyle(
                              fontSize: 10,
                              color: _currentSelection == 1
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600),
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
                        key: _reservedKey,
                        onTap: () => _selectedItem(2),
                        child: Text(
                          'Reserved',
                          style: TextStyle(
                              fontSize: 10,
                              color: _currentSelection == 2
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600),
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
                        key: _claimKey,
                        onTap: () => _selectedItem(3),
                        child: Text(
                          'Claim',
                          style: TextStyle(
                              fontSize: 10,
                              color: _currentSelection == 3
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: Container(color: Colors.black26),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
          builder: (context, state) {
            if (_showLoading) {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json',
                      height: 300, width: 380, fit: BoxFit.fill));
            }
            if (state is StudentBagCombinedLoadSuccessState) {
              items = state.studentBagItems;
              books = state.studentBagBooks;
            }

            return ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Text(
                  'Uniform',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                ItemList(
                  status: items.where((item) {
                    switch (_currentSelection) {
                      case 1:
                        return item.status == "Request";
                      case 2:
                        return item.status == "Reserved";
                      case 3:
                        return item.status == "Claim";
                      default:
                        return false;
                    }
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Books',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                BookList(
                  status: books.where((book) {
                    switch (_currentSelection) {
                      case 1:
                        return book.status == "Request";
                      case 2:
                        return book.status == "Reserved";
                      case 3:
                        return book.status == "Claim";
                      default:
                        return false;
                    }
                  }).toList(),
                ),
              ],
            );
          },
        ),
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
      children: status.map((e) => ItemCard(item: e)).toList(),
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
                child: Image.network("https://example.com/your_image.jpg"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Department :',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.department,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Code :',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.code ?? 'N/A',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      item.status,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Claimed :',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.dateReceived?.toLocal().toIso8601String() ??
                              'N/A',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Department: ${item.department}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Code: ${item.code ?? 'N/A'}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Type: ${item.type}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Body: ${item.body}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Size: ${item.size}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Status: ${item.status}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Date Received: ${item.dateReceived?.toLocal().toIso8601String() ?? 'N/A'}',
                                style: TextStyle(
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
  const BookList({Key? key, required this.status}) : super(key: key);
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
                child: Image.network(
                    "assets/b19d1b570a8d62ff56f4f351e389c2db.jpg"), // Placeholder for actual image
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
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.bookName,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Code :',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.code,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        book.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Claimed :',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            book.dateReceived?.toLocal().toIso8601String() ??
                                'N/A',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book : ${book.bookName}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Subject Code : ${book.subjectCode}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Subject Desc : ${book.subjectDesc}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Status: ${book.status}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Date Received: ${book.dateReceived?.toLocal().toIso8601String() ?? 'N/A'}',
                                style: TextStyle(
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
