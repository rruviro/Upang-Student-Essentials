// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
class newDepartment extends StatefulWidget {
  const newDepartment({super.key});
  @override
  State<newDepartment> createState() => _newDepartmentState();
}

class _newDepartmentState extends State<newDepartment> {
  
  TextEditingController _controller = TextEditingController();
  List<Widget> _rows = [];
  int _counter = 0;
  final int maxLength = 25;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCounter);
  }

  void _updateCounter() {
    setState(() {
      _counter = _controller.text.length;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateCounter);
    _controller.dispose();
    super.dispose();
  }

  void _addRow() {
    setState(() {
      final screenWidth = MediaQuery.of(context).size.width;
      _rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 40,
              child: TextFormField(
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
                    fontWeight: FontWeight.w600,
                  ),
                  suffix: Text(
                    '$_counter/$maxLength',
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
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(maxLength),
                ],
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
              width: screenWidth * 0.5,
              height: 40,
              child: TextFormField(
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
                    fontWeight: FontWeight.w600,
                  ),
                  suffix: Text(
                    '$_counter/$maxLength',
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
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(maxLength),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
 

  @override
  Widget build(BuildContext context) {

    File? _image;

    Future<void> _openImagePicker() async {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            child: Visual(context)
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
                            controller: _controller,
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
                                fontWeight: FontWeight.w600,
                              ),
                              suffix: Text(
                                '$_counter/$maxLength', 
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
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(maxLength),
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          height: 150,
                          child: ListView(
                            children: _rows
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
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _openImagePicker();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : const Text('Please select an image'),
                      ),
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
                            
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 170, 113),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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

Widget Visual (BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final itemWidth = 50.0;
  final spacing = 10.0;
  final initialSpacing = 50.0;
  final availableWidth = screenWidth * 0.5 - initialSpacing;
  final itemsPerRow = (availableWidth / (itemWidth + spacing)).floor();
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
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
            child: Image.asset(
              'assets/vanguards.png',
              width: 220,
              height: 220, 
            ),
          ),
        ),
        Positioned(
          child: InkWell(
            onTap: () {
            },
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
                      'Health Science',
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
                          fontWeight: FontWeight.w600,
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
                ...List.generate(itemsPerRow * 2, (index) {
                  return Container(
                    width: itemWidth,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(1, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'BSN',
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 14, 170, 113),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
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
