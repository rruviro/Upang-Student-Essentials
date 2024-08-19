// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/History.dart';
import 'package:use/UI/Core/admin/notification.dart';
import 'package:use/UI/Core/admin/profile/transaction.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
  
class _ProfileScreenState extends State<Profile> {
  int _currentSelection = 1;
  GlobalKey _Complete = GlobalKey();
  GlobalKey _Cancelled = GlobalKey();
  _selectedItem(int id) {
    _currentSelection = id;
    GlobalKey selectedGlobalKey;
    switch (id) {
      case 1:
        selectedGlobalKey = _Complete;
        break;
      case 2:
        selectedGlobalKey = _Cancelled;
        break;
      default: 
    }
    setState(() {
      
    });
  }
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
                'Upang Admin Essentials',
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
              Icons.backpack, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout, 
              color: Color.fromARGB(255, 14, 170, 113)
            ),
            onPressed: () {
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
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          maxWidth: 260.0,
                        ),
                        child: Container(
                          width: 250,
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
                                      Icons.request_page_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Request',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 30),
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
                              SizedBox(width: 30),
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
                              SizedBox(width: 30),
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
                                      Icons.back_hand_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Claim',
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
                    SizedBox(height: 30),
                    Text(
                      'History',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          key: _Complete,
                          onTap: () => _selectedItem(1),
                          child: Text(
                            'Complete',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: _currentSelection == 1
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.grey,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 25,
                          width: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          key: _Cancelled,
                          onTap: () => _selectedItem(2),
                          child: Text(
                            'Cancelled',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: _currentSelection == 2
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.grey,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                    ItemList(
                      status : products
                          .where(
                            (element) => element.category == _currentSelection
                          )
                          .toList()
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
          margin: const EdgeInsets.only(
            bottom: 30.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 14, 170, 113),
             boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
                    top: 55,
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
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Department :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            product.department,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Reserved :',
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
                      SizedBox(height: 10),
                      Text(
                        product.status,
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
                            'Claimed :',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            product.claimedDate,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
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
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        content: Image.asset('assets/b19d1b570a8d62ff56f4f351e389c2db.jpg'),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.info_outline, 
                  size: 15.0,
                  color: Color.fromARGB(255, 14, 170, 113),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}