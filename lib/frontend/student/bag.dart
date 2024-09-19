

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/backpack.dart';
import 'package:use/frontend/student/profile/transaction.dart';
import 'package:use/frontend/student/widgets/bag.dart';

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
          bag_widget (
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