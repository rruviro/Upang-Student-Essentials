// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/UI/Core/admin/home/stocks.dart';
import 'package:use/UI/Core/admin/profile/profile.dart';
void main() => runApp(MaterialApp(
  home: courses(),
));

class courses extends StatefulWidget {
  @override
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  String _selectedYear = "First Year";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
      bloc: adminBloc,
      listenWhen: (previous, current) => current is AdminActionState,
      buildWhen: (previous, current) => current is! AdminActionState,
      listener: (context, state) {
        if (state is StockPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stocks()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminLoadingState():
            return CircularProgressIndicator();
          default:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 14, 170, 113),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Transform.translate(
                  offset: Offset(-15.0, 0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Course',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'Department: ',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: ListView(
                children: [
                  SizedBox(height: 20),
                  ItemList(
                    status : details
                  )
                ],
              ),
            );
        }
      }
    );
  }
}

class ItemList extends StatelessWidget {
  final List<course> status;
  const ItemList({Key? key, required this.status}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
        .map((e) => ItemCard(
            product: e,
          ))
        .toList(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final course product;
  const ItemCard({Key? key, required this.product}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 13
          ),
          child: InkWell(
            onTap: () {
              adminBloc.add(StockPageEvent()); 
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF0EAA72),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(1, 8),
                  ),
                ],
              ),
              child: Stack( 
                children: [
                  Positioned(
                    top: 17,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BSN',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          'Bachelor of Science in Nursing',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 60,
                    child: SizedBox(
                      height: 70,
                      width: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    right: 20,
                    child: Icon(
                      Icons.arrow_forward_ios, 
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
