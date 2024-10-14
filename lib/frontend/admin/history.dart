// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
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
  List<StudentBagBook> books = [];
  bool _showLoading = true;

  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    context.read<AdminExtendedBloc>().add(studentBagItem());
    context.read<AdminExtendedBloc>().add(studentBagBook());
  }

  @override
  void dispose() {
    super.dispose();
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
            ),
          ];
        },
        body: BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
          listener: (context, state) {
            if (state is StudentBagCombinedLoadSuccessState) {
              setState(() {
                items = state.studentBagItems;
                books = state.studentBagBooks;
              });
            }
            if (state is StudentBagCombinedLoadSuccessState) {
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is studentLoading) {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json',
                      height: 300, width: 380, fit: BoxFit.fill));
            }
            if (_showLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StudentBagCombinedLoadSuccessState) {
              return Container(
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
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            child: InkWell(
                              onTap: () {
                                // Navigate to view all books
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
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                      ),
                    ),
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
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            child: InkWell(
                              onTap: () {
                                // Navigate to view all uniforms
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
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
