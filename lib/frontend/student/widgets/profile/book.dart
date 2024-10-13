import 'package:flutter/material.dart';

import '../../../../backend/models/student/StudentBagData/StudentBagBook.dart';
import '../../../colors/colors.dart';

class book_list extends StatelessWidget {
  final List<StudentBagBook> status;
   book_list({Key? key, required this.status}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Make it horizontal
      child: Row(  // Wrap with Row to display BookCards horizontally
        children: status
          .map((e) => BookCard(
              book: e,
            ))
          .toList(),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final StudentBagBook book;
   BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 180,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: primary_color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondary_color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  "assets/book.png",
                  fit: BoxFit.cover,  
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Text(
                              "${book.bookName ?? 'N/A'}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Text(
                              "${book.department ?? 'N/A'}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Code : AHUKSN",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white60,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
