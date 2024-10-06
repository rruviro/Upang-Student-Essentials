// ignore_for_file: prefer__ructors
import 'package:flutter/material.dart';
import 'package:use/frontend/student/widgets/profile/uniform.dart';

import '../../../backend/models/student/StudentBagData/StudentBagItem.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<StudentBagItem> items = [];
  int _currentSelection = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color.fromARGB(255, 0, 0, 0)),
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
        child: ListView(
          children: [
            SizedBox(height: 20),
            uniform_list(
              status: items.toList(),
            ),
          ],
        )
      )
    );
  }
}