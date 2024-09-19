// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:use/frontend/admin/home/home.dart';
import 'package:use/frontend/student/home/course.dart';
class newDepartment extends StatefulWidget {
  const newDepartment({super.key});
  @override
  State<newDepartment> createState() => _newDepartmentState();
}

class _newDepartmentState extends State<newDepartment> {
  
  final TextEditingController DepartmentName = TextEditingController();
  final TextEditingController Courses = TextEditingController();
  final TextEditingController Bachelor = TextEditingController();

  final int maxLength = 25;
  List<Map<String, dynamic>> _rows = [];

  int _countDepartment = 0;
  int _countCourse = 0;
  int _countBachelor = 0;

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DepartmentName.addListener(_updateCounter);
  }

  void _updateCounter() {
    setState(() {
      _countDepartment = DepartmentName.text.length;
    });
  }

  @override
  void dispose() {
    DepartmentName.removeListener(_updateCounter);
    DepartmentName.dispose();
    super.dispose();
  }

  void _deleteItem(int index) {
    setState(() {
      _rows[index]['coursesController'].dispose();
      _rows[index]['bachelorController'].dispose();
      _rows.removeAt(index);
    });
  }

  void _addRow() {
    bool canAdd = true;

    for (var row in _rows) {
      if (row['coursesController'].text.isEmpty || row['bachelorController'].text.isEmpty) {
        canAdd = false;
        break;
      }
    }

    if (canAdd) {
      setState(() {
        TextEditingController coursesController = TextEditingController();
        TextEditingController bachelorController = TextEditingController();
        _rows.add({
          'coursesController': coursesController,
          'bachelorController': bachelorController,
          'countCourse': 0,
          'countBachelor': 0,
        });
      });
    } else {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            title: Container(
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.error,
                  color: Color.fromARGB(255, 255, 47, 47),
                  size: 100,
                ),
              )
            ),
            content: Container(
              height: 40,
              child: Center(
                child: Text(
                  'Please fill in the current course field before adding another row.',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: Offset(-15.0, 0.0),
          child: Text(
            'New Department',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        bottom: AppBar(
          toolbarHeight: 200,
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            child: Visual(context, DepartmentName.text, _rows, _image)
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Stack(
        children:[
          ListView(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Department Name',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 40,
                          child: TextFormField(
                            controller: DepartmentName,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                              ),
                              hintText: 'Health Science',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              suffix: Text(
                                '$_countDepartment/23', 
                                style: TextStyle(
                                  color: Color.fromARGB(255, 14, 170, 113),
                                  fontSize: 12,
                                ),
                              ),
                              suffixStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(23),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Text(
                                  'Course(s)',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: 0,
                                child: IconButton(
                                  iconSize: 15,
                                  icon: Icon(Icons.add, color: Color.fromARGB(255, 14, 170, 113)),
                                  onPressed: _addRow
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          height: 150,
                          child: ListView.builder(
                            itemCount: _rows.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _rows[index]['coursesController'],
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                                          ),
                                          hintText: 'BSN',
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          suffix: Text(
                                            '${_rows[index]['countCourse']}/10',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 14, 170, 113),
                                              fontSize: 12,
                                            ),
                                          ),
                                          suffixStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        onChanged: (text) {
                                          setState(() {
                                            _rows[index]['countCourse'] = text.length;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Padding(
                                      padding: EdgeInsets.only(top: 13),
                                      child: SizedBox(
                                        height: 28,
                                        width: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      width: screenWidth * 0.34,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _rows[index]['bachelorController'],
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                                          ),
                                          hintText: 'Bachelor of Science in Nursing',
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          suffix: Text(
                                            '${_rows[index]['countBachelor']}/25',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 14, 170, 113),
                                              fontSize: 12,
                                            ),
                                          ),
                                          suffixStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (text) {
                                          setState(() {
                                            _rows[index]['countBachelor'] = text.length;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _deleteItem(index),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Department Logo',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _openImagePicker();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 170, 113),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: _image != null
                                ? Image.file(
                                    _image!, 
                                    fit: BoxFit.cover
                                  )
                                : Icon(
                                    Icons.image_search_rounded,color: 
                                    Colors.white,
                                  ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Primary Color',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Circle(0, Color.fromRGBO(6, 143, 255, 1)),
                                  _Circle(1, const Color.fromARGB(255, 255, 62, 62)),
                                  _Circle(2, Color.fromARGB(255, 255, 169, 30)),
                                  _Circle(3, Color.fromARGB(255, 14, 170, 113)),
                                  Container(
                                    padding: EdgeInsets.only(right: 13),
                                    child: SizedBox(
                                      height: 20,
                                      width: 1,
                                      child: Container(color:Colors.black26),
                                    ),
                                  ),
                                  _Circle(4, Color.fromARGB(255, 14, 170, 113)),
                                ],
                              ),
                            ),
                            SizedBox(height: 23),
                            Text(
                              'Secondary Color',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Circle(0, Color.fromRGBO(6, 143, 255, 1)),
                                  _Circle(1, const Color.fromARGB(255, 255, 62, 62)),
                                  _Circle(2, Color.fromARGB(255, 255, 169, 30)),
                                  _Circle(3, Color.fromARGB(255, 14, 170, 113)),
                                  Container(
                                    padding: EdgeInsets.only(right: 13),
                                    child: SizedBox(
                                      height: 20,
                                      width: 1,
                                      child: Container(color:Colors.black26),
                                    ),
                                  ),
                                  _Circle(4, Color.fromARGB(255, 14, 170, 113)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 0,
                        left: 0,
                        bottom: 20,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  title: Container(
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Color.fromARGB(255, 14, 170, 113),
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                  content: Container(
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        'New Department is already deploy!',
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
                                                  builder: (context) => Home(),
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
                                                  'Home',
                                                  style: GoogleFonts.inter(
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
                                                  style: GoogleFonts.inter(
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
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 170, 113),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: Offset(1, 8),
                                ),
                              ]
                            ),
                            child: Center(
                              child: Text(
                                'Deploy',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600
                                  )
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
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

Widget _Circle(int index, Color color) {
  final int _selectedIndex = 1;
  bool isSelected = _selectedIndex == index;

  return InkWell(
    onTap: () {
    },
    child: Container(
      margin: EdgeInsets.only(right: 15.0),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: Color.fromARGB(116, 255, 255, 255), width: 2.0) // Stroke when selected
            : null, // No border when not selected
      ),
    ),
  );
}

Widget Visual (BuildContext context, String DepartmentName, List<Map<String, dynamic>> courses, File? image) {
  final screenWidth = MediaQuery.of(context).size.width;
  final itemWidth = 50.0;
  final spacing = 10.0;
  final initialSpacing = 50.0;
  final maxVisibleItems = 4;
  
  return Container (
    margin: const EdgeInsets.only(
      bottom: 30.0,
    ),
    height: 150,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 14, 170, 113),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 5,
          offset: Offset(1, 8),
        ),
      ],
    ),
    width: double.infinity,
    child: Stack(
      children: [
        Positioned(
          right: -20,
          top: -35,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5)
              )
            ),
            child: image!=null
              ? ClipRRect(
                  child: Image.file(
                    image!,
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                'assets/vanguards.png',
                width: 220,
                height: 220, 
              ),
            width: 220,
            height: 220, 
          ),
        ),
        Positioned(
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 14, 170, 113),
                    Color.fromARGB(123, 14, 170, 113),
                  ],
                  stops: [0.50, 0.70],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      left: 30.0
                    ),
                    child: Text(
                      DepartmentName.isNotEmpty
                        ? DepartmentName
                        : 'Department Name',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle (
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 9.0,
                      left: 30.0
                    ),
                    child: Text(
                      'Courses :',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle (
                          fontSize: 10,
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 55.0,
                      left: 30.0
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 46,
          left: 30,
          child: Container(
            width: screenWidth * 0.5,
            height: 40,
            child: Wrap(
              spacing: spacing, 
              runSpacing: spacing,
              alignment: WrapAlignment.start,
              children: [
                SizedBox(width: 50),
                ...List.generate(
                  courses.length > maxVisibleItems ? maxVisibleItems : courses.length,
                  (index) {
                    String displayText = courses[index]['coursesController'].text;
                    return Container(
                      width: itemWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          displayText,
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 14, 170, 113),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (courses.length > maxVisibleItems)
                  Container(
                    width: itemWidth,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+${courses.length - maxVisibleItems} more',
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 14, 170, 113),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 30,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white54,
                size: 20
              ),
              SizedBox(width: 10),
              Text(
                'Show more courses',
                style: GoogleFonts.inter(
                  textStyle: TextStyle (
                    fontSize: 10,
                    color: Colors.white54,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
