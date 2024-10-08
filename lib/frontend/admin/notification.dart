import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/model/student/Notification.dart';

class notif extends StatefulWidget {
  const notif({super.key, required int studentProfile});

  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  final TextEditingController _controller = TextEditingController();
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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
                            ? Colors.black
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
                            ? Colors.black
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
                            ? Colors.black
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
                // child: ItemList(
                //   status: _currentSelection == 3
                //       ? products 
                //       : products
                //           .where(
                //               (element) => element.category == _currentSelection)
                //           .toList(),
                // ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                title: Text(
                  'New Notification',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Container(
                  width: double.infinity,
                  height: 40,
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 14, 170, 113)),
                      ),
                      hintText: 'Good Morning Students!',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromARGB(255, 14, 170, 113)
                      ),
                      child: Center( 
                        child: Text(
                          'Publish',
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
                      width: 112,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromARGB(192, 14, 170, 113)
                      ),
                      child: Center(
                        child:Text(
                          'Cancel',
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
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 14, 170, 113),
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
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(1, 5),
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
