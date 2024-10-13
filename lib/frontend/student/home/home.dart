// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< Updated upstream
=======
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
>>>>>>> Stashed changes
import 'package:use/SERVICES/model/student/Department.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
import 'package:use/frontend/student/home/course.dart';
import 'package:use/frontend/student/home/uniform.dart';
import 'package:use/frontend/student/notification.dart';
import 'package:use/frontend/student/widgets/home/home.dart';

import '../../admin/home/stocks.dart';

final StudentExtendedBloc studBloc = StudentExtendedBloc();
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }
  
  @override 
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      bloc: studBloc,
      listenWhen: (previous, current) => current is StudentActionState,
      buildWhen: (previous, current) => current is! StudentActionState,
      listener: (context, state) {
        if (state is NotificationPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => notif()));
        } else if (state is BackpackPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Bag()));
        } else if (state is CoursePageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => courses()));
        } else if (state is UniformPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
        }
      },
      builder: (context, state) {
<<<<<<< Updated upstream
        switch (state.runtimeType) {
          case StudentLoadingState():
            return CircularProgressIndicator();
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
                title: Transform.translate(
                  offset: Offset(-15.0, 0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departments',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Choose your perspective department for -',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
=======
        if (state is DepartmentsLoadingState) {
          return Center(child: Lottie.asset(
              'assets/lottie/loading.json',
              height: 300,
              width: 380,
              fit: BoxFit.fill
            ));
        } else if (state is DepartmentsLoadedState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool isScrolled){
                return [
                  SliverAppBar(
                    title: Container(
                      width: double.infinity,
                      height: 35,
                      child: Row(
                        children: [
                          Image.asset('assets/logo.png'),
                          SizedBox(width: 10),
                          Text(
                            'Upang Student Essentials',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
>>>>>>> Stashed changes
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                centerTitle: false,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications, 
                      color: Colors.white
                    ),
<<<<<<< Updated upstream
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
                  SizedBox(width: 15),
                ],
                elevation: 0,
=======
                    backgroundColor: Colors.white,
                  ),
                ];
              }, 
              body: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(-15.0, 0.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Departments',
                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Choose your perspective department for -',
                                        style: TextStyle(color: tertiary_color, fontSize: 10, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            home_widget(departments: state.departments, profile: widget.studentProfile,), 
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          );
        } else if (state is DepartmentsErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }
}

class home_widget extends StatelessWidget {
  final List<department> departments;
  final StudentProfile profile;
  const home_widget({Key? key, required this.departments, required this.profile}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: departments
          .map((e) => ItemCard(visual: e, profile: this.profile,))
          .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final department visual;
  final StudentProfile profile;
  const ItemCard({Key? key, required this.visual, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => courses(
              departmentID: visual.id ?? 0,
              departmentName: visual.name,
              profile: this.profile,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        height: 80,
        decoration: BoxDecoration(
          color: primary_color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -35,
              child: Container(
                child: Image.asset(
                  visual.photo,
                  width: 220,
                  height: 220,
                ),
>>>>>>> Stashed changes
              ),
              body: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            home_widget (
                              departments : initials
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
      },
    );
  }
}