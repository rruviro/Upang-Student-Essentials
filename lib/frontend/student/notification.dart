import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';
import 'package:use/frontend/colors/colors.dart';

class notif extends StatefulWidget {
  const notif({super.key, required this.studentProfile});
  final StudentProfile studentProfile;
  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  int _currentSelection = 1;
  final GlobalKey _Inbox = GlobalKey();

  List<StudentNotifcationMail> mails = [];
  
  @override
  void initState() {
    super.initState();
    context.read<StudentExtendedBloc>().add(studentNotificationMail(widget.studentProfile.id));
  }
  
  Future<bool> _onPop() async {
    Navigator.pop(context, false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(123123);
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        backgroundColor: Colors.white,
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
      ),
    ));
  }
}

class ItemList extends StatelessWidget {
  final List<StudentNotifcationMail> status;
  const ItemList({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map(
            (e) => ItemCard(
              mails: e,
            ),
          )
          .toList(),
    );
  }
}

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
