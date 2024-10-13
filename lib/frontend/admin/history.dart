// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:use/frontend/admin/profile/books.dart';
import 'package:use/frontend/student/widgets/profile/uniform.dart';

import '../../backend/models/student/StudentBagData/StudentBagItem.dart';
import '../colors/colors.dart';
import '../student/widgets/profile/book.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  int _currentSelection = 1;
  GlobalKey _Complete = GlobalKey();
  GlobalKey _Cancelled = GlobalKey();
  List<StudentBagItem> items = [];
  
  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
      String status = id == 1 ? "Complete" : "Cancelled";
      // final bloc = context.read<StudentExtendedBloc>();
      // bloc.add(studentBagItem(widget.studentProfile.id, status));
      // bloc.add(studentBagBook(widget.studentProfile.id, status));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                'History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // floating: true, 
              // pinned: false,   
              // expandedHeight: 120.0, 
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Padding(
              //     padding: const EdgeInsets.only(left: 17, top: 50.0), 
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           children: [
              //             InkWell(
              //               key: _Complete,
              //               onTap: () => _selectedItem(1),
              //               child: Text(
              //                 '',
              //                 style: TextStyle(
              //                   fontSize: 10,
              //                   color: _currentSelection == 1 ? primary_color : tertiary_color,
              //                   fontWeight: _currentSelection == 1 ? FontWeight.w600 : FontWeight.w400,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(width: 15),
              //             InkWell(
              //               key: _Cancelled,
              //               onTap: () => _selectedItem(2),
              //               child: Text(
              //                 'Cancelled',
              //                 style: TextStyle(
              //                   fontSize: 10,
              //                   color: _currentSelection == 2 ? primary_color : tertiary_color,
              //                   fontWeight: _currentSelection == 2 ? FontWeight.w600 : FontWeight.w400,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 10), // Add some space below the buttons
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
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
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Positioned(
                      right: -5,
                      child: InkWell(
                        onTap: () {
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
                    // child: book_list(
                    //   status: books
                    //       .where((book) =>
                    //           book.status ==
                    //           (_currentSelection == 1
                    //               ? "Complete"
                    //               : "Cancelled"))
                    //       .toList(),
                    // ),
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
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Positioned(
                      right: -5,
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => uniforms(
                          //           studentProfile:
                          //               widget.studentProfile)),
                          // );
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
      )
    );
  }
}