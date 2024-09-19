import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/admin/Announcement.dart';

class announcement_widget extends StatelessWidget {
  final List<announcement> status;
  const announcement_widget({Key? key, required this.status}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
        .map((e) => ItemCard(
            details: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final announcement details;
  const ItemCard({Key? key, required this.details}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 15.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                offset: Offset(1, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 14, 170, 113),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0
                ),
                child: Text(
                  details.description,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 10
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 26,
          left: 10,
          child: Container(
            child: Center(
              child: Text(
                details.department,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 26,
          right: 10,
          child: Container(
            child: Center(
              child: Text(
                details.published,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}