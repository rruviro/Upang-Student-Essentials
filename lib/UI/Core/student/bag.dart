

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/backpack.dart';

void main() => runApp(MaterialApp(
  home: Bag(),
));

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => BagState();
}
class BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 170, 113),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: Offset(-15.0, 0.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Backpack',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            )
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          ItemList(
            status : details
          )
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<backpack> status;
  const ItemList({Key? key, required this.status}) : super (key: key);
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

class ItemCard extends StatefulWidget { 
  final backpack details;
  const ItemCard({Key? key, required this.details}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isChecked = false; 
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
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 14, 170, 113),
                    ),
                    child: Image.asset(
                      widget.details.image,
                      fit: BoxFit.contain, 
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.details.product, 
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 14, 170, 113),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Year : ' + widget.details.year,
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Course : ' + widget.details.course,
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Size : ' + widget.details.size,
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 16,
                              width: 1,
                              child: Container(color: Colors.grey),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Quantity : ' + widget.details.quantity,
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 0.99,
                child: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Color.fromARGB(255, 14, 170, 113),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 14),
                child: Center(
                  child: Text(
                    widget.details.department,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}