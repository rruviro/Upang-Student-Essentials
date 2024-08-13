// ignore_for_file: prefer_const_constructors
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/Transaction.dart';
class Transaction extends StatefulWidget {
  const Transaction({super.key});
  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
          'Transaction',
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
                      'Request',
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
                      'Pending',
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
                      'Reserved',
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
                  InkWell(
                    key: _Claim,
                    onTap: () => _selectedItem(4),
                    child: Text(
                      'Claim',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 4
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
                  color: Colors.black26
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          ItemList(
            categoryList: status
                .where(
                  (element) => element.category == _currentSelection
                ).toList()
          )
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<TransactionStatus> categoryList;
  const ItemList({Key? key, required this.categoryList}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: categoryList
        .map((e) => ItemCard(
            visual: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final TransactionStatus visual;
  const ItemCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Image.network(
              visual.imageUrl,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
