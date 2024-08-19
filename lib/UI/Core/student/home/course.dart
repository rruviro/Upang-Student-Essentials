import 'package:flutter/material.dart';

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
                    Text(
                      'Year',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 2),
                    ),
                    SizedBox(
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
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                width: 20,
              ),
              IconButton(
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                onPressed: () {
                  // function
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(13),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF0EAA72),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text('BSN', style: TextStyle(color: Colors.white)),
              subtitle: Text('Bachelor of Science in Nursing', style: TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                    width: 20,
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
              onTap: () {
                // function
              },
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF0EAA72),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text('BSN', style: TextStyle(color: Colors.white)),
              subtitle: Text('Bachelor of Science in Nursing', style: TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                    width: 20,
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
              onTap: () {
                // function
              },
            ),
          ),
        ],
      ),
    );
  }
}
