import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/colors/colors.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/home/uniform.dart';
import 'package:use/frontend/student/widgets/home/stocks.dart';

class Stocks extends StatefulWidget {
  final int courseID;
  final String courseName;
  final String Department;
  final StudentProfile profile;

  const Stocks({
    super.key,
    required this.courseID,
    required this.courseName,
    required this.Department,
    required this.profile,
  });

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  String? _course;
  int? _id;
  String? bookCourse;
  List<StudentBagBook> items = [];

  @override
  void initState() {
    super.initState();
    bookCourse = widget.courseName;
    getCourse();
    context
        .read<StudentExtendedBloc>()
        .add(ShowStocksEvent(Course: widget.courseName)); // EDITED NI LANCE
  }

  Future<void> getCourse() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    _course = sharedPref.getString('course');
    _id = sharedPref.getInt('stubagid');
    print("id: $_id");
    context.read<StudentExtendedBloc>().add(allstudentBagBook(_id!, "All"));
  }

  void _showBookDialog(BuildContext context, Book book) {
    String selectedShift = 'Shift A';
    List<String> shiftDays = ['Shift A: M|T|W', 'Shift B: TH|F|S'];

    bool bookExists = items.any((item) => item.bookName == book.BookName);
    bool isCourseDifferent = _course != widget.courseName;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            book.BookName,
            style: TextStyle(color: primary_color, fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.SubjectDesc,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Claiming Schedule:',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedShift,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedShift = newValue!;
                      });
                    },
                    items:
                        shiftDays.map<DropdownMenuItem<String>>((String shift) {
                      return DropdownMenuItem<String>(
                        value: shift.split(':')[0],
                        child: Text(shift),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),
                  if (bookExists) ...[
                    Text(
                      'BOOK ALREADY EXISTED',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                  ],
                  if (isCourseDifferent) ...[
                    Text(
                      'UNAVAILABLE FOR YOUR COURSE',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _course == widget.courseName && !bookExists
                              ? () {
                                  context.read<StudentExtendedBloc>().add(
                                        AddStudentBagBook(
                                          _id!,
                                          widget.courseName, // DAGDAG NI LANCE
                                          widget.Department,
                                          book.BookName,
                                          book.SubjectCode,
                                          book.SubjectDesc,
                                          "ACTIVE",
                                          selectedShift == 'Shift A'
                                              ? 'A'
                                              : 'B',
                                        ),
                                      );
                                  context.read<StudentExtendedBloc>().add(
                                        createNotification(
                                          _id!,
                                          'The Book "${book.BookName}" you\'ve requested is now in your BAG.',
                                        ),
                                      );
                                  setState(() {
                                    items.add(StudentBagBook(
                                      reservationNumber: 0,
                                      id: 0,
                                      department: '',
                                      bookName: book.BookName,
                                      subjectCode: '',
                                      subjectDesc: '',
                                      code: '',
                                      status: '',
                                      claimingSchedule: '',
                                      stubagId: 0,
                                      shift: '',
                                    ));
                                  });
                                  Navigator.of(context).pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary_color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: Icon(Icons.backpack, size: 20),
                          label: Text("Add to Backpack",
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _course == widget.courseName && !bookExists
                              ? () {
                                  if (book.Stock != 0) {
                                    context.read<StudentExtendedBloc>().add(
                                        bookreduceStocks(
                                            count: book.Stock,
                                            department: widget.Department,
                                            bookname: book.BookName,
                                            subcode: book.SubjectCode,
                                            subdesc: book.SubjectDesc));
                                  }
                                  context.read<StudentExtendedBloc>().add(
                                        AddReserveBagBook(
                                          _id!,
                                          widget.courseName, //DAGDAG NI LANCE
                                          widget.Department,
                                          book.BookName,
                                          book.SubjectCode,
                                          book.SubjectDesc,
                                          "Request",
                                          selectedShift == 'Shift A'
                                              ? 'A'
                                              : 'B',
                                          1,
                                        ),
                                      );

                                  setState(() {
                                    items.add(StudentBagBook(
                                      reservationNumber: 0,
                                      id: 0,
                                      department: '',
                                      bookName: book.BookName,
                                      subjectCode: '',
                                      subjectDesc: '',
                                      code: '',
                                      status: '',
                                      claimingSchedule: '',
                                      stubagId: 0,
                                      shift: '',
                                    ));
                                  });

                                  Navigator.of(context).pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primary_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: primary_color),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: Icon(Icons.request_page, size: 20),
                          label:
                              Text("Request", style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
      listener: (context, state) {
        if (state is StudentBagBookLoadSuccessState) {
          setState(() {
            items = state.studentBagBook;
          });
        } else if (state is UniformPageState) {}
      },
      builder: (context, state) {
        if (state is StocksLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StocksLoadedState) {
          print(items.length);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primary_color,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              title: Transform.translate(
                offset: Offset(-15.0, 0.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Stocks',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('Course: ${widget.courseName}',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.backpack_outlined, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider<StudentExtendedBloc>.value(
                        value: studBloc,
                        child: Bag(
                            studentProfile: widget.profile, Status: "ACTIVE"),
                      ),
                    ));
                  },
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView(
                children: [
                  Text('Uniform',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 15),
                  Container(
                    height: 270,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        stocks_widget(
                          stocks: state.stocks,
                          courseName: widget.courseName,
                          profile: widget.profile,
                          department: widget.Department,
                        ),
                      ],
                    ),
                  ),
                  Text('Books',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: primary_color,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            offset: Offset(1, 5))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: state.books.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Icon(Icons.shopping_bag,
                                  size: 50, color: Colors.grey),
                            )
                          : BookList(
                              books: state.books, onTap: _showBookDialog),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is StocksErrorState) {
          print("hatdog");
          return Center(child: Text(state.error));
        } else {
          print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
          print(state);
          print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;
  final Function(BuildContext context, Book book) onTap;

  const BookList({Key? key, required this.books, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: books.map((book) {
        return BookCard(
          visual: book,
          onTap: () => onTap(context, book),
        );
      }).toList(),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book visual;
  final VoidCallback onTap;

  const BookCard({Key? key, required this.visual, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(visual.BookName,
              style: TextStyle(fontSize: 13, color: Colors.white)),
          subtitle: Text(visual.SubjectDesc,
              style: TextStyle(
                  fontSize: 10, color: Colors.white.withOpacity(0.7))),
          iconColor: Colors.white,
          leading: Icon(Icons.book, size: 32),
          onTap: onTap,
        ),
        Divider(color: Colors.white.withOpacity(0.7), thickness: 1),
      ],
    );
  }
}
