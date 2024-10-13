// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< Updated upstream
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/History.dart';
import 'package:use/frontend/authentication/StudentLogin.dart';
=======
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/notificationService/notificationService.dart';
import 'package:use/frontend/Authentication/StudentLogin.dart';
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
  
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
=======

  @override
  void dispose() {
    // ProdController.removeListener(_updateCounter);
    // ProdController.dispose();
    super.dispose();
  }

  void _selectedItem(int id) {
    setState(() {
      _currentSelection = id;
      String status = id == 1 ? "Complete" : "Cancelled";
      final bloc = context.read<StudentExtendedBloc>();
      bloc.add(studentBagItem(widget.studentProfile.id, status));
      bloc.add(studentBagBook(widget.studentProfile.id, status));
    });
  }

  void showChangePasswordDialog(BuildContext context, StudentProfile studentProfile) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    int maxLength = 25;
    bool isPasswordChanged = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              title: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Container(
                height: 90,
                width: double.infinity,
                child: isPasswordChanged
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: primary_color,
                            size: 70,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Password Changed!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primary_color,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: TextFormField(
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                ),
                                hintText: 'New Password',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffix: Text(
                                  '${newPasswordController.text.length}/$maxLength',
                                  style: TextStyle(
                                    color: primary_color,
                                    fontSize: 12,
                                  ),
                                ),
                                suffixStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(23),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: TextFormField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primary_color),
                                ),
                                hintText: 'Confirm New Password',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffix: Text(
                                  '${confirmPasswordController.text.length}/$maxLength',
                                  style: TextStyle(
                                    color: primary_color,
                                    fontSize: 12,
                                  ),
                                ),
                                suffixStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(23),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              actions: !isPasswordChanged
                  ? [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final newPassword = newPasswordController.text;
                              final confirmPassword = confirmPasswordController.text;

                              if (newPassword == confirmPassword && newPassword.isNotEmpty) {
                                context.read<StudentExtendedBloc>().add(
                                      changePassword(studentProfile.id, newPassword, confirmPassword),
                                    );
                                setState(() {
                                  isPasswordChanged = true;
                                });
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.of(context).pop();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passwords do not match or the new password is empty.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 112,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: primary_color,
                              ),
                              child: Center(
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 30,
                              width: 112,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: primary_color,
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ),
                      ]
                    )
                    ]
                  : [],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled){
          return [
            SliverAppBar(
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: false,
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    showChangePasswordDialog(context, widget.studentProfile);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary_color,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Icon(Icons.lock, size: 15,color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'Are you sure you wanna logout?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () async {
                                _notificationService?.stopPolling();
                                final SharedPreferences logout =
                                    await SharedPreferences.getInstance();
                                logout.clear();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => StudnetLogin()),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 112,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: primary_color,
                                ),
                                child: Center(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
>>>>>>> Stashed changes
                                    ),
                                  ),
                                ),
                              ),
<<<<<<< Updated upstream
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
=======
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 112,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: primary_color
                                ),
                                child: Center(
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary_color,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Icon(Icons.logout, size: 15,color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            )
          ];
        }, 
        body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
          builder: (context, state) {
            if (_showLoading) {
              return Center(child: Lottie.asset(
              'assets/lottie/loading.json',
              height: 300,
              width: 380,
              fit: BoxFit.fill
            ));
            }
            if (state is StudentBagCombinedLoadSuccessState) {
              items = state.studentBagItems;
              books = state.studentBagBooks;
            }
            switch (state.runtimeType) {
              case StudentLoadingState:
                return Center(child: Lottie.asset(
              'assets/lottie/loading.json',
              height: 300,
              width: 380,
              fit: BoxFit.fill
            ));
              case StudentErrorState:
                return Center(child: Text('Error'));
              default:
                return ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 54,
                                    width: 54,
                                    decoration: BoxDecoration(
                                      color: primary_color,
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  VerticalDivider(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.studentProfile.firstName} ${widget.studentProfile.lastName}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Course: ${widget.studentProfile.course}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.studentProfile.stuId} | Year: ${widget.studentProfile.year} |",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${widget.studentProfile.status}',
                                            style: TextStyle(
                                              color: primary_color,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.center,
                                child: FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: SizedBox(
                                    height: 20,
                                    width: double.infinity,
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: secondary_color),
                                    ),
                                  ),
                                )),
                              SizedBox(height: 20),
                              Container(
                                height: 20,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: Text(
                                        'Transaction',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            height: 20,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                'View Transaction >',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: tertiary_color,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primary_color,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5,
                                      offset: Offset(1, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  padding: EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                  Transaction(
                                                    page: 1,
                                                    studentProfile: widget
                                                        .studentProfile,
                                                    status: 'Request')
                                                  ),
                                            );
                                            if (result == true) {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            } else {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            }
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
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        InkWell(
                                          onTap: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Transaction(
                                                          page: 2,
                                                          studentProfile: widget
                                                              .studentProfile,
                                                          status: 'Reserved')),
                                            );
                                            if (result == true) {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            } else {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            }
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
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        InkWell(
                                          onTap: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Transaction(
                                                          page: 3,
                                                          studentProfile: widget
                                                              .studentProfile,
                                                          status: 'Claim')),
                                            );
                                            if (result == true) {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            } else {
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagBook(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                              context
                                                  .read<StudentExtendedBloc>()
                                                  .add(studentBagItem(
                                                      widget.studentProfile.id,
                                                      "Complete"));
                                            }
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
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                  alignment: Alignment.center,
                                  child: FractionallySizedBox(
                                    widthFactor: 1.2,
                                    child: SizedBox(
                                      height: 20,
                                      width: double.infinity,
                                      child: Container(
                                        decoration:
                                            BoxDecoration(color: secondary_color),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20),
                              Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
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
                                              ? primary_color
                                              : tertiary_color,
                                          fontWeight: _currentSelection == 1
                                              ? FontWeight.w600
                                              : FontWeight.w400),
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
                                              ? primary_color
                                              : tertiary_color,
                                          fontWeight: _currentSelection == 2
                                              ? FontWeight.w600
                                              : FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                height: 1,
                                width: double.infinity,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black26),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 20,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: Text(
                                        'Books',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -5,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Books(
                                                    studentProfile:
                                                        widget.studentProfile)),
                                          );
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                'View All Books >',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: tertiary_color,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.center,
                                child: FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: items.isEmpty
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
                                    : Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 40),
                                      child: FractionallySizedBox(
                                        widthFactor: 1.2,
                                        child: book_list(
                                          status: books
                                              .where((book) =>
                                                  book.status ==
                                                  (_currentSelection == 1
                                                      ? "Complete"
                                                      : "Cancelled"))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                )
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 20,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: Text(
                                        'Uniform',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -5,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => uniforms(
                                                    studentProfile:
                                                        widget.studentProfile)),
                                          );
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                'View All Uniform >',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: tertiary_color,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              items.isEmpty
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
                                : uniform_list(
                                  status: items
                                      .where((item) =>
                                          item.status ==
                                          (_currentSelection == 1
                                              ? "Complete"
                                              : "Cancelled"))
                                      .toList(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
            }
          },
        ),
      )
>>>>>>> Stashed changes
    );
  }
}

