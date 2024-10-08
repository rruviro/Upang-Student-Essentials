// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:use/backend/bloc/student/student_bloc.dart';
// import 'package:use/SERVICES/model/student/Department.dart';
// import 'package:use/frontend/student/home/home.dart';
//
// import '../../../colors/colors.dart';
//
// class home_widget extends StatelessWidget {
//   final List<Departments> departments;
//   const home_widget({Key? key, required this.departments}) : super (key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: departments
//         .map((e) => ItemCard(
//             visual: e,
//           ))
//         .toList(),
//     );
//   }
// }
//
// class ItemCard extends StatelessWidget {
//   final Departments visual;
//   const ItemCard({Key? key, required this.visual}) : super (key: key);
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final itemWidth = 50.0;
//     final spacing = 10.0;
//     final initialSpacing = 50.0;
//     final availableWidth = screenWidth * 0.5 - initialSpacing;
//     final itemsPerRow = (availableWidth / (itemWidth + spacing)).floor();
//     return Container (
//       margin: const EdgeInsets.only(
//         bottom: 20.0,
//       ),
//       height: 80,
//       decoration: BoxDecoration(
//         color: primary_color,
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             blurRadius: 2,
//             offset: Offset(1, 1),
//           ),
//         ],
//       ),
//       width: double.infinity,
//       child: Stack(
//         children: [
//           Positioned(
//             right: -20,
//             top: -35,
//             child: Container(
//               child: Image.asset(
//                 visual.imageUrl,
//                 width: 220,
//                 height: 220,
//               ),
//             ),
//           ),
//           Positioned(
//             child: InkWell(
//               onTap: () {
//                 studBloc.add(CoursePageEvent());
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   gradient: LinearGradient(
//                     colors: [
//                       primary_color,
//                       Color.fromARGB(43, 14, 170, 113),
//                     ],
//                     stops: [0.50, 0.70],
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 25.0,
//                         left: 30.0
//                       ),
//                       child: Text(
//                         visual.department,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: 30.0
//                       ),
//                       child: Container(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }