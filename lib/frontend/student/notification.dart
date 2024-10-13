import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< Updated upstream
import 'package:use/SERVICES/model/student/Notification.dart';
import 'package:use/frontend/student/widgets/notification.dart';
=======
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';
import 'package:use/frontend/colors/colors.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
=======
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Notification',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
          builder: (context, state) {
            if (state is StudentNotificationMailLoadSuccessState) {
              mails = state.studentNotifcationMail;
            } else if (state is StudentNotificationMailLoadingState) {
              print("here");
              return Center(child: CircularProgressIndicator());
            } else if (state is StudentNotificationMailErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return ListView(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: mails.isEmpty
                    ? Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/empty_state/announcement.png",
                            height: 160,
                            width: 160,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No announcements available',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  : ItemList(
                    status: mails.toList(),
                  ),
                ),
              ],
            );
          
        }
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======

class ItemCard extends StatelessWidget {
  final StudentNotifcationMail mails;
  const ItemCard({Key? key, required this.mails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(25),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/b19d1b570a8d62ff56f4f351e389c2db.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
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
                          mails.description,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          mails.time.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: tertiary_color,
              width: double.infinity,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
