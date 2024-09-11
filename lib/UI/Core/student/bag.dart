

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/backpack.dart';
import 'package:use/UI/Core/student/home/home.dart';
import 'package:use/UI/Core/student/profile/transaction.dart';

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
    bool isChecked = false; 
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
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: 70,
        color: Color.fromARGB(255, 14, 170, 113),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              bottom: 15,
              left: 20,
              child: Container(
                width: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Transform.scale(
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
                    ),
                    SizedBox(width: 5),
                    Center(
                      child: Text(
                        'Select All Items',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
            Positioned(
              top: 15,
              bottom: 15,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Text(
                            'Price: 0',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          Text(
                            'Quantity: 0',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            title: Container(
                              height: 100,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Color.fromARGB(255, 14, 170, 113),
                                  size: 100,
                                ),
                              ),
                            ),
                            content: Container(
                              height: 20,
                              child: Center(
                                child: Text(
                                  'Successful, Check your order in your transaction now.',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => Transaction()),
                                        );
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Color.fromARGB(255, 14, 170, 113),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Transaction',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Color.fromARGB(192, 14, 170, 113),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Close',
                                            style: GoogleFonts.inter(
                                              color: Color.fromARGB(190, 255, 255, 255),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(1, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Request',
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 14, 170, 113),
                            fontSize: 13,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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