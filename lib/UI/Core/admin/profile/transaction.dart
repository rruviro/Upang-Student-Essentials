// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/models/admin/Transaction.dart';
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
                      'Approval',
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
                      'Reserved',
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
                      'Pending',
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
                      'Complete',
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
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemList(
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
    switch (visual.status) {
      case 'Request':
        return _buildRequest(context);
      case 'Reserved':
        return _buildReserved(context);
      case 'Pending':
        return _buildPending(context);
      case 'Complete':
        return _buildComplete(context);
      default:
        return _buildDefaultCard(context);
    }
  }

  Widget _buildRequest(BuildContext context) {
    return _buildBaseCard(
      context: context,
      color: Color.fromARGB(255, 14, 170, 113),
      status: 'Request',
    );
  }

  Widget _buildReserved(BuildContext context) {
    return _default(
      context: context,
      color: Color.fromARGB(255, 14, 170, 113),
      status: 'Reserved',
    );
  }

  Widget _buildPending(BuildContext context) {
    return _default(
      context: context,
      color: Color.fromARGB(255, 14, 170, 113),
      status: 'Pending',
    );
  }

  Widget _buildComplete(BuildContext context) {
    return _default(
      context: context,
      color: Color.fromARGB(255, 14, 170, 113),
      status: 'Complete',
    );
  }

  Widget _buildDefaultCard(BuildContext context) {
    return _buildBaseCard(
      context: context,
      color: Colors.grey,
      status: 'Unknown',
    );
  }

  Widget _buildBaseCard({
    required BuildContext context, 
    required Color color, 
    required String status
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color, 
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
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: 120,
                  color: Colors.white,
                  child: Image.network(
                    visual.imageUrl,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
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
                      Text(
                        visual.consumer,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        visual.studentID,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        status,
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
                            visual.reservedDate,
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
                      Row(
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  'Accept',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 14, 170, 113),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  'Deny',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 14, 170, 113),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
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
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _default({
    required BuildContext context, 
    required Color color, 
    required String status
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color, // Use the passed color
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
                child: Container(
                  width: 120,
                  color: Colors.white,
                  child: Image.network(
                    visual.imageUrl,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
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
                        visual.consumer,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        visual.studentID,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        status, // Use the passed status
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
                            visual.reservedDate,
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
                  color: color, // Use the passed color for consistency
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
