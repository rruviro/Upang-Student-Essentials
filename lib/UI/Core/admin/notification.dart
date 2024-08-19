import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/Notification.dart';

class notif extends StatefulWidget {
  const notif({super.key});

  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  int _currentSelection = 1;
  final GlobalKey _Inbox = GlobalKey();
  final GlobalKey _Antique = GlobalKey();
  final GlobalKey _All = GlobalKey();

  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Transform.translate(
          offset: Offset(-15.0, 0.0),
          child: Text(
            'Notification',
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
                    key: _Inbox,
                    onTap: () => _selectedItem(1),
                    child: Text(
                      'Inbox',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 1
                            ? Color.fromARGB(255, 0, 0, 0)
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 25,
                    width: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black26),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    key: _Antique,
                    onTap: () => _selectedItem(2),
                    child: Text(
                      'Antique',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 2
                            ? Color.fromARGB(255, 0, 0, 0)
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 25,
                    width: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black26),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    key: _All,
                    onTap: () => _selectedItem(3),
                    child: Text(
                      'All',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: _currentSelection == 3
                            ? Color.fromARGB(255, 0, 0, 0)
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
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
                child: Container(color: Colors.black26),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.all(10.0),
                child: ItemList(
                  status: _currentSelection == 3
                      ? products 
                      : products
                          .where(
                              (element) => element.category == _currentSelection)
                          .toList(),
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
  final List<notifModel> status;
  const ItemList({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map(
            (e) => ItemCard(
              detail: e,
            ),
          )
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final notifModel detail;
  const ItemCard({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 10.0,
      ),
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
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              Container(
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(30),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            detail.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white30),
                ),
              ),
              SizedBox(width: 15),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100.0,
                  maxWidth: 200.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.description,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      detail.postDate,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

// InkWell(
//   onTap: () => NotificationService.createNewNotification(),
//   child: Container(
//     color: Colors.black,
//     height: 100,
//     width: 100,
//   )
// )
