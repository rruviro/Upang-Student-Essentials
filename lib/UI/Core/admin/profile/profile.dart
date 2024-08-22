// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/admin/History.dart';
import 'package:use/UI/Authentication/AdminLogin.dart';
import 'package:use/UI/Core/admin/notification.dart';
import 'package:use/UI/Core/admin/profile/transaction.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
  
class _ProfileScreenState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          width: double.infinity, 
          height: 35, 
          child: Row(
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(width: 10),
              Text(
                'Upang Student Essentials',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
              Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => notif()
                )
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    content: Text(
                      'Are you sure you wanna logout',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => AdminLogin()
                            )
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 116,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color.fromARGB(255, 14, 170, 113)
                          ),
                          child: Center( 
                            child: Text(
                              'Continue',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600 
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 116,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color.fromARGB(192, 14, 170, 113)
                          ),
                          child: Center(
                            child:Text(
                              'Nope',
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(190, 255, 255, 255),
                                fontSize: 13,
                                fontWeight: FontWeight.w600 
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
                  );
                }
              );
            },
          ),
          SizedBox(width: 15),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ramon Montenegro',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                    Text(
                      '01-1234-432154',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 1,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Transaction',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 14, 170, 113),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(1, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: 254.0,
                          ),
                          child: Container(
                            height: 80,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => Transaction()
                                      )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 13),
                                      Icon(
                                        Icons.approval,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Approval',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 25),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => Transaction()
                                      )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 13),
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Reserved',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 25),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => Transaction()
                                      )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 13),
                                      Icon(
                                        Icons.pending_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Pending',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 25),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => Transaction()
                                      )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 13),
                                      Icon(
                                        Icons.check_box_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Complete',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Cancelled',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 20),
                    ItemList(
                      status : products
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<History> status;
  const ItemList({Key? key, required this.status}) : super (key: key);
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
  final History product;
  const ItemCard({Key? key, required this.product}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 14, 170, 113),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(width: 10),
              Stack(
                children: [
                  Positioned(
                    top: 59,
                    left: 0,
                    child: SizedBox(
                      height: 1,
                      width: 500,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 19),
                      Text(
                        product.consumer,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        product.studentID,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.status, // Use the passed status
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Reserved:',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            product.reservedDate,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // Info Button
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        title: Text(
                          'Details',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: Image.asset(
                          'assets/b19d1b570a8d62ff56f4f351e389c2db.jpg',
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  size: 15.0,
                  color: Color.fromARGB(255, 14, 170, 113)
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}