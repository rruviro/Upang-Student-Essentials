import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/Course.dart';
import 'package:use/frontend/student/home/home.dart';

import '../../../colors/colors.dart';

class course_widget extends StatelessWidget {
  final List<course> status;
  const course_widget({Key? key, required this.status}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
        .map((e) => ItemCard(
            product: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final course product;
  const ItemCard({Key? key, required this.product}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 13
          ),
          child: InkWell(
            onTap: () {
              studBloc.add(StockPageEvent()); 
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: primary_color,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: Offset(1, 5),
                  ),
                ],
              ),
              child: Stack( 
                children: [
                  Positioned(
                    top: 17,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BSN',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          'Bachelor of Science in Nursing',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 60,
                    child: SizedBox(
                      height: 70,
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    right: 20,
                    child: Icon(
                      Icons.arrow_forward_ios, 
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
