import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/Notification.dart';
import 'package:use/frontend/student/widgets/notification.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                        fontWeight: _currentSelection == 3
                          ? FontWeight.w600
                          : FontWeight.w400
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
                child: notification_widget(
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

class notification_widget extends StatelessWidget {
  final List<notifModel> status;
  const notification_widget({Key? key, required this.status}) : super(key: key);

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
