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
                title: Container(
                  width: double.infinity, 
                  height: 35, 
                  child: Row(
                    children: [
                      Image.asset('assets/logo.png'),
                      SizedBox(width: 10),
                      Text(
                        'Upang Student Essentials',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: false,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      studBloc.add(NotificationPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.backpack, 
                      color: Color.fromARGB(255, 14, 170, 113)
                    ),
                    onPressed: () {
                      studBloc.add(BackpackPageEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout, 
                      color: Color.fromARGB(255, 14, 170, 113)
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
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            content: Text(
                              'Are you sure you wanna logout',
                              style: GoogleFonts.inter(
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
                                      'Nope',
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
                        }
                      );
                    },
                  ),
                  SizedBox(width: 15),
                ],
                backgroundColor: Colors.white,
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
                              'Ramon Montenegro',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            Text(
                              '01-1234-432154',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400
                                )
                              ),
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
                            SizedBox(height: 20),
                            Text(
                              'Transaction',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                                              style: GoogleFonts.inter(
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
                                              style: GoogleFonts.inter(
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
                                              style: GoogleFonts.inter(
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
                            SizedBox(height: 30),
                            Text(
                              'History',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                InkWell(
                                  key: _Complete,
                                  onTap: () => _selectedItem(1),
                                  child: Text(
                                    'Complete',
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
                                  key: _Cancelled,
                                  onTap: () => _selectedItem(2),
                                  child: Text(
                                    'Cancelled',
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

