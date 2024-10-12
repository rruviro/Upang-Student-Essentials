// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../colors/colors.dart';

class manage extends StatefulWidget {
  const manage({super.key});
  @override
  State<manage> createState() => _manageState();
}

class _manageState extends State<manage> {
  final TextEditingController DepartmentName = TextEditingController();
  final TextEditingController Courses = TextEditingController();
  final TextEditingController Bachelor = TextEditingController();

  final int maxLength = 25;
  List<Map<String, dynamic>> _rows = [];

  int _countDepartment = 0;

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
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
      if (row['coursesController'].text.isEmpty ||
          row['bachelorController'].text.isEmpty) {
        canAdd = false;
        break;
      }
    }

    if (canAdd) {
      setState(() {
        TextEditingController coursesController = TextEditingController();
        TextEditingController bachelorController = TextEditingController();

        // Insert the new row at the beginning (index 0) for descending order
        _rows.insert(0, {
          'coursesController': coursesController,
          'bachelorController': bachelorController,
          'countCourse': 0,
          'countBachelor': 0,
        });
      });
    } else {
      print(
          'Please fill in the current course field before adding another row.');
    }
  }

  Color _currentColor = Colors.blue;
  final List<Color> availableColors = [
    Color.fromARGB(255, 255, 0, 0), // Red
    Color.fromARGB(255, 0, 255, 0), // Green
    Color.fromARGB(255, 0, 0, 255), // Blue
    Color.fromARGB(255, 255, 255, 0), // Yellow
    Color.fromARGB(255, 255, 165, 0), // Orange
    Color.fromARGB(255, 128, 0, 128), // Purple
    Color.fromARGB(255, 255, 192, 203), // Pink
    Color.fromARGB(255, 0, 0, 0), // Black
    Color.fromARGB(255, 128, 128, 128), // Gray
  ];
  int? _selectedIndex;

  void _selectColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
            offset: Offset(-15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'manage health and science details ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )),
      ),
      body: Stack(
        children: [
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
                              fontWeight: FontWeight.w500),
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
                                borderSide: BorderSide(color: primary_color),
                              ),
                              hintText: 'Health Science',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              suffix: Text(
                                '$_countDepartment/23',
                                style: TextStyle(
                                  color: primary_color,
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
                    SizedBox(height: 10),
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
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: 0,
                                child: IconButton(
                                    iconSize: 15,
                                    icon: Icon(Icons.add, color: primary_color),
                                    onPressed: _addRow),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: primary_color,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 3,
                                  offset: Offset(1, 1),
                                ),
                              ]),
                          width: double.infinity,
                          height: 250,
                          child: ListView.builder(
                            itemCount: _rows.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _rows[index]
                                            ['coursesController'],
                                        decoration: InputDecoration(
                                          hintText: 'BSIT',
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hoverColor: Colors.white,
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .white), // Color when unfocused
                                          ),
                                          suffix: Text(
                                            '${_rows[index]['countCourse']}/10',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          suffixStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        onChanged: (text) {
                                          setState(() {
                                            _rows[index]['countCourse'] =
                                                text.length;
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
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _rows[index]
                                            ['bachelorController'],
                                        decoration: InputDecoration(
                                          hintText:
                                              'Bachelor of information in technology',
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hoverColor: Colors.white,
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          suffix: Text(
                                            '${_rows[index]['countBachelor']}/25',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          suffixStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (text) {
                                          setState(() {
                                            _rows[index]['countBachelor'] =
                                                text.length;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.white),
                                        onPressed: () => _deleteItem(index),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            _openImagePicker();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                color: primary_color,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  ),
                                ]),
                            child: _image != null
                                ? Image.file(_image!, fit: BoxFit.cover)
                                : Icon(
                                    Icons.image_search_rounded,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Primary Color',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 200,
                          height:
                              50, // Adjusted height to give GridView enough space
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  7, // Number of columns for the grid
                              childAspectRatio:
                                  1, // Aspect ratio to keep squares
                            ),
                            itemCount: availableColors.length - 2,
                            itemBuilder: (context, index) {
                              final color = availableColors[index +
                                  2]; // Adjust index for remaining colors
                              final isSelected = _selectedIndex ==
                                  index; // Check if the color is selected
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex =
                                        index; // Update selected index
                                  });
                                  _selectColor(color);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape
                                        .circle, // Make the container circular
                                    border: isSelected
                                        ? Border.all(
                                            color: const Color.fromARGB(255,
                                                187, 187, 187), // Stroke color
                                            width: 2.0, // Stroke width
                                          )
                                        : null,
                                  ),
                                  margin: EdgeInsets.all(4.0),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 0,
                        left: 0,
                        bottom: 20,
                      ),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary_color,
                              minimumSize: Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
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
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(right: 15.0),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                color: Color.fromARGB(116, 255, 255, 255),
                width: 2.0) // Stroke when selected
            : null, // No border when not selected
      ),
    ),
  );
}
