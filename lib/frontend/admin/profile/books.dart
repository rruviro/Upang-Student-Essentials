// ignore_for_file: prefer__ructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/admin/widgets/profile/books.dart';

class Books extends StatefulWidget {
  final StudentProfile studentProfile;
  const Books({super.key, required this.studentProfile});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<StudentBagBook> items = [];
  int _currentSelection = 1;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showLoading = false;
      });
    });
    context
        .read<StudentExtendedBloc>()
        .add(allstudentBagBook(widget.studentProfile.id, "Complete"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Books',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
                builder: (context, state) {
              if (_showLoading) {
                return Center(
                    child: Lottie.asset('assets/lottie/loading.json',
                        height: 300, width: 380, fit: BoxFit.fill));
              }
              if (state is StudentBagBookLoadSuccessState) {
                items = state.studentBagBook;
              }
              return ListView(
                children: [
                  books_list(
                    status: items,
                  ),
                ],
              );
            })));
  }
}
