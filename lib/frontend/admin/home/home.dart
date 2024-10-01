// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconoir_flutter/regular/color_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:use/SERVICES/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Department.dart';
import 'package:use/frontend/admin/home/course.dart';
import 'package:use/frontend/admin/home/management/manage.dart';
import 'package:use/frontend/admin/home/uniform.dart';
import 'package:use/frontend/admin/notification.dart';

final AdminExtendedBloc adminBloc = AdminExtendedBloc();
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController DepartmentName = TextEditingController();
  final TextEditingController Courses = TextEditingController();
  final TextEditingController Bachelor = TextEditingController();

  final int maxLength = 25;
  List<Map<String, dynamic>> _rows = [];

  int _countDepartment = 0;
  int _countCourse = 0;
  int _countBachelor = 0;

  File? _image;

  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    DepartmentName.addListener(_updateCounter);
  }

  @override
  void dispose() {
    DepartmentName.removeListener(_updateCounter);
    DepartmentName.dispose();
    super.dispose();
  }

  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _updateCounter() {
    setState(() {
      _countDepartment = DepartmentName.text.length;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _rows[index]['coursesController'].dispose();
      _rows[index]['bachelorController'].dispose();
      _rows.removeAt(index);
    });
  }

  Color _currentColor = Colors.blue;
  final List<Color> availableColors = [
    Color.fromARGB(255, 255, 0, 0),   // Red
    Color.fromARGB(255, 0, 255, 0),   // Green
    Color.fromARGB(255, 0, 0, 255),   // Blue
    Color.fromARGB(255, 255, 255, 0),  // Yellow
    Color.fromARGB(255, 255, 165, 0),  // Orange
    Color.fromARGB(255, 128, 0, 128),  // Purple
    Color.fromARGB(255, 255, 192, 203), // Pink
    Color.fromARGB(255, 0, 0, 0),       // Black
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
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is CoursePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => courses()));
        } else if (state is ManagePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => manage()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminLoadingState():
            return CircularProgressIndicator();
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
                title: Transform.translate(
                  offset: Offset(-15.0, 0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departments',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Choose your perspective department for -',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                automaticallyImplyLeading: false,
                centerTitle: false,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            title: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Icon(Icons.drive_folder_upload_outlined),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Add New Department',
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Enter new department details',
                                        style: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 400,
                              width: double.infinity,
                              child: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: DepartmentName,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                                          ),
                                          hintText: 'Department',
                                          hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                                        onChanged: (text) {
                                          setState(() {
                                            _countDepartment = text.length;
                                          });
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(23),
                                        ],
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: Courses,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                                                ),
                                                hintText: 'BSIT',
                                                hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                suffix: Text(
                                                  '$_countCourse/15',
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
                                              onChanged: (text) {
                                                setState(() {
                                                  _countCourse = text.length;
                                                });
                                              },
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(15),
                                              ],
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction.done,
                                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                              validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              controller: Bachelor,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                                                ),
                                                hintText: 'Bachelor of information in technology',
                                                hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                suffix: Text(
                                                  '$_countBachelor/25',
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
                                              onChanged: (text) {
                                                setState(() {
                                                  _countBachelor = text.length;
                                                });
                                              },
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(25),
                                              ],
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction.done,
                                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Department logo',
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
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
                                      SizedBox(height: 10),
                                      Text(
                                        'Primary Color',
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 250,
                                        height: 50,
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 7, // Number of columns for the grid
                                            childAspectRatio: 1, // Aspect ratio to keep squares
                                          ),
                                          itemCount: availableColors.length - 2,
                                          itemBuilder: (context, index) {
                                            final color = availableColors[index + 2]; // Adjust index for remaining colors
                                            final isSelected = _selectedIndex == index; // Check if the color is selected
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedIndex = index; // Update selected index
                                                });
                                                _selectColor(color);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  shape: BoxShape.circle, // Make the container circular
                                                  border: isSelected
                                                      ? Border.all(
                                                          color: const Color.fromARGB(255, 187, 187, 187), // Stroke color
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
                                      ElevatedButton(
                                        onPressed: (){},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 14, 170, 113), 
                                          minimumSize: Size(double.infinity, 50), 
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), 
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Add',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Colors.white
                    ),
                    onPressed: () {
                      adminBloc.add(NotificationPageEvent());
                    },
                  ),
                  SizedBox(width: 15),
                ],
                elevation: 0,
              ),
              body: Stack(
                children:[
                  ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10), 
                                ItemList (
                                  departments : initials
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
      }
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Departments> departments;
  const ItemList({Key? key, required this.departments}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: departments
        .map((e) => ItemCard(
            visual: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Departments visual;
  const ItemCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 50.0;
    final spacing = 10.0;
    final initialSpacing = 50.0;
    final availableWidth = screenWidth * 0.5 - initialSpacing;
    final itemsPerRow = (availableWidth / (itemWidth + spacing)).floor();
    return Container (
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 170, 113),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(1, 5),
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
                visual.imageUrl,
                width: 220,
                height: 220, 
              ),
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                adminBloc.add(CoursePageEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 14, 170, 113),
                      Color.fromARGB(43, 14, 170, 113),
                    ],
                    stops: [0.50, 0.70],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25.0,
                        left: 30.0
                      ),
                      child: Text(
                        visual.department,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
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
            top: 0,
            right: 0,
            child: Container(
              width: 85,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: Color.fromARGB(227, 255, 255, 255)
              ),
              child: InkWell(
                onTap: () {
                  adminBloc.add(ManagePageEvent());
                },
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Manage',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 10.5,
                          color: Color.fromARGB(255, 14, 170, 113),
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: Color.fromARGB(255, 14, 170, 113),
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}