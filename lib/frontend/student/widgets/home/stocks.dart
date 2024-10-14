import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/admin/Course.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/Stocks.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/home/uniform.dart';

import '../../../colors/colors.dart';

class stocks_widget extends StatelessWidget {
  final List<Stock> stocks;
  final String courseName;
  final String department;
  final StudentProfile profile;

  const stocks_widget(
      {Key? key,
      required this.stocks,
      required this.courseName,
      required this.profile,
      required this.department})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: stocks
          .map((stock) => ItemCard(
                stock: stock,
                courseName: courseName,
                profile: profile,
                department: this.department,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Stock stock;
  final String courseName;
  final String department;
  final StudentProfile profile;

  const ItemCard(
      {Key? key,
      required this.stock,
      required this.courseName,
      required this.profile,
      required this.department})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UniformStudent(
                          courseName: courseName,
                          profile: this.profile,
                          department: this.department,
                          type: this.stock.stockName,
                          Gender: stock.Gender,
                          UniformType: stock.Type,
                          Body: stock.Body,
                          stockPhoto: stock.photoUrl,
                        )));
          },
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: primary_color,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(1, 8),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      stock.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${stock.stockName} ${stock.Body}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
