import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/UI/Core/student/home/stocks.dart';

void main() => runApp(MaterialApp(
  home: Course(),
));

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  String _selectedYear = "First Year";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0EAA72),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Department: ',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        'Year',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 100),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: SizedBox(
                        width: 100,
                        height: 20,
                        child: DropdownButton<String>(
                          value: _selectedYear,
                          dropdownColor: Color(0xFF0EAA72),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                          underline: SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedYear = newValue!;
                            });
                          },
                          items: <String>[
                            'First Year',
                            'Second Year',
                            'Third Year',
                            'Fourth Year'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white, fontSize: 13),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  onPressed: () {
                    // function
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(13),
        children: [
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Stocks())); 
            },
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF0EAA72),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(1, 8),
                  ),
                ],
              ),
              child: Stack( // List Tile
                children: [
                  Positioned(
                    top: 20,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BSN',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          'Bachelor of Science in Nursing',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 65,
                    child: SizedBox(
                      height: 80,
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 28,
                    right: 20,
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
