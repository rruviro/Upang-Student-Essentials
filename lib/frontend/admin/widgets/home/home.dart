import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/SERVICES/model/admin/Department.dart';
import 'package:use/frontend/admin/profile/profile.dart';


class home_widget extends StatelessWidget {
  final List<Departments> departments;
  const home_widget({Key? key, required this.departments}) : super (key: key);
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
        bottom: 30.0,
      ),
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 170, 113),
        borderRadius: BorderRadius.circular(10),
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
                        visual.department,
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
                        top: 5.0,
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
                  ...List.generate(itemsPerRow * 2, (index) {
                    return Container(
                      width: itemWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          visual.courses,
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
