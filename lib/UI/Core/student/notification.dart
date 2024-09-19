import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(10.0),
                      child: ItemList(
                        status: mails.toList(),
                      ),
                    ),
                  ],
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
                      mails.description,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      mails.time.toString(),
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
