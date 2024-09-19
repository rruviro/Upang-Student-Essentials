// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/Transaction.dart';
import 'package:use/frontend/student/widgets/profile/transaction.dart';
class Transaction extends StatefulWidget {
  const Transaction({super.key});
  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  int _currentSelection = 1;
  GlobalKey _Request = GlobalKey();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: Offset(-15.0, 0.0),
          child: Text(
            'Transaction',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        bottom: AppBar(
          toolbarHeight: 35,
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
                      'Request',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 1
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey,
                        fontWeight: _currentSelection == 1
                          ? FontWeight.w600
                          : FontWeight.w400
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
                    onTap: () => _selectedItem(2),
                    child: Text(
                      'Reserved',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 2
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey,
                        fontWeight: _currentSelection == 2
                          ? FontWeight.w600
                          : FontWeight.w400
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
                    key: _Claim,
                    onTap: () => _selectedItem(3),
                    child: Text(
                      'Claim',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 3
                          ? Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey,
                        fontWeight: _currentSelection == 3
                          ? FontWeight.w600
                          : FontWeight.w400
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
                  color: Colors.black26
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
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
                transaction_widget (
                  categoryList: products
                      .where(
                        (element) => element.category == _currentSelection
                      ).toList()
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}