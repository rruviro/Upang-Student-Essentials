// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class notif extends StatefulWidget {
  const notif({super.key});
  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  int _currentSelection = 1;
  GlobalKey _Request = GlobalKey();
  GlobalKey _Pending = GlobalKey();
  GlobalKey __Reserved = GlobalKey();
  GlobalKey _Claim = GlobalKey();
  _selectedItem(int id) {
    _currentSelection = id;
    GlobalKey selectedGlobalKey;
    switch (id) {
      case 1:
        selectedGlobalKey = _Request;
        break;
      case 2:
        selectedGlobalKey = _Pending;
        break;
      case 3:
        selectedGlobalKey = __Reserved;
        break;
      case 3:
        selectedGlobalKey = _Claim;
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
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600
            )
          ),
        ),
        bottom: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    key: _Request,
                    onTap: () => _selectedItem(1),
                    child: Text(
                      'Inbox',
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
                    key: _Pending,
                    onTap: () => _selectedItem(2),
                    child: Text(
                      'Antique',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 2
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
                    key: __Reserved,
                    onTap: () => _selectedItem(3),
                    child: Text(
                      'All',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 3
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
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 1, 
                width: double.infinity,
                child: Container(
                  color: Colors.black26
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [

        ],
      )
    );
  }
}