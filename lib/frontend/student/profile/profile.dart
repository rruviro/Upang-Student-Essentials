// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/History.dart';
import 'package:use/frontend/authentication/StudentLogin.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/frontend/student/profile/transaction.dart';
import 'package:use/frontend/student/widgets/profile/history.dart';

final StudentExtendedBloc studBloc = StudentExtendedBloc();
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
  
class _ProfileScreenState extends State<Profile> {
  int _currentSelection = 1;
  GlobalKey _Complete = GlobalKey();
  GlobalKey _Cancelled = GlobalKey();
  _selectedItem(int id) {
    _currentSelection = id;
    GlobalKey selectedGlobalKey;
    switch (id) {
      case 1:
        selectedGlobalKey = _Complete;
        break;
      case 2:
        selectedGlobalKey = _Cancelled;
        break;
      default: 
    }
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      bloc: studBloc,
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is BackpackPageState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Bag()));
        } else if (state is TransactionPageState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Transaction()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case StudentLoadingState():
            return CircularProgressIndicator();
          case StudentErrorState():
            return Scaffold(body: Center(child: Text('Error')));
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
                centerTitle: false,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Colors.white
                    ),
                    onPressed: () {
                      studBloc.add(NotificationPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.backpack, 
                      color: Colors.white
                    ),
                    onPressed: () {
                      studBloc.add(BackpackPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout, 
                      color: Colors.white
                    ),
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            content: Text(
                              'Are you sure you wanna logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            actions: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => StudnetLogin()
                                    )
                                  );
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
                                      'Continue',
                                      style: TextStyle(
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
                                      'Nope',
                                      style: TextStyle(
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
                        }
                      );
                    },
                  ),
                  SizedBox(width: 15),
                ],
                elevation: 0,
              ),
              body: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                          "Montenegah, Ramon",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Course: Bachelor of information and technology",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01-1113-023898 | Year: Third Year |",
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Enrolled',
                              style: GoogleFonts.inter(
                                color: Color.fromARGB(255, 14, 170, 113),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Transaction',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 90,
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
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                padding: const EdgeInsets.only(top: 5),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          studBloc.add(TransactionPageEvent());
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Icon(
                                              Icons.request_page_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Request',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      InkWell(
                                        onTap: () {
                                          studBloc.add(TransactionPageEvent());
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Reserved',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      InkWell(
                                        onTap: () {
                                          studBloc.add(TransactionPageEvent());
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Icon(
                                              Icons.back_hand_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Claim',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'History',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                InkWell(
                                  key: _Complete,
                                  onTap: () => _selectedItem(1),
                                  child: Text(
                                    'Complete',
                                    style: TextStyle(
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
                                SizedBox(width: 15),
                                SizedBox(
                                  height: 25,
                                  width: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black26
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                InkWell(
                                  key: _Cancelled,
                                  onTap: () => _selectedItem(2),
                                  child: Text(
                                    'Cancelled',
                                    style: TextStyle(
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
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            history_widget (
                              status : products
                                  .where(
                                    (element) => element.category == _currentSelection
                                  )
                                  .toList()
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
      }
    );
  }
}

