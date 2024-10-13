import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/Notification.dart';

class ItemCard extends StatelessWidget {
  final notifModel detail;
  const ItemCard({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 14, 170, 113),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(1, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              Container(
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(30),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            detail.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100.0,
                  maxWidth: 200.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.description,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      detail.postDate,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

