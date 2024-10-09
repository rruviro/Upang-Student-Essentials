import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/frontend/colors/colors.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/home/uniform.dart';
import 'package:use/frontend/student/widgets/home/stocks.dart';

class Stocks extends StatefulWidget {
  final int courseID;
  final String courseName;
  final String Department;

  const Stocks({super.key, required this.courseID, required this.courseName, required this.Department});
  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  void initState() {
    super.initState();
    context.read<StudentExtendedBloc>().add(ShowStocksEvent(Department: widget.Department));
  }

  List<bool> _bottomSheetSelectedBooks = List.generate(5, (index) => false);
  List<bool> _containerSelectedBooks = List.generate(5, (index) => false);

  void _showBookDialog(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            book.BookName,
            style: TextStyle(
              color: primary_color,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.SubjectDesc,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add to backpack logic here
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary_color,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.backpack, size: 20),
                      label: Text(
                        "Add to Backpack",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Request logic here
                        Navigator.of(context).pop();
                      },
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
                      label: Text(
                        "Request",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentExtendedBloc, StudentExtendedState>(
        listenWhen: (previous, current) => current is StudentActionState,
        buildWhen: (previous, current) => current is! StudentActionState,
        listener: (context, state){
          if (state is UniformPageState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UniformStudent()));
          }
        },
        builder: (context, state) {
          if (state is StocksLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StocksLoadedState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primary_color,
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
                          'Stocks',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'Course : ${widget.courseName} ',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.backpack_outlined, color: Colors.white),
                    onPressed: () {
                      studBloc.add(BackpackPageEvent());
                    },
                  ),
                  SizedBox(width: 15),
                ],
              ),
              body: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Uniform',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 270,
                          width: double.infinity,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                child: stocks_widget(stocks: state.stocks,),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Books',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            color: primary_color,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 5,
                                offset: Offset(1, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView(
                              children: [
                                BookList(books: state.books, onTap: _showBookDialog),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is StocksErrorState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;
  final Function(BuildContext, Book) onTap;
  const BookList({Key? key, required this.books, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: books.map((book) => BookCard(visual: book, onTap: () => onTap(context, book))).toList(),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book visual;
  final VoidCallback onTap;
  const BookCard({
    Key? key,
    required this.visual,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            visual.BookName,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            visual.SubjectDesc,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          iconColor: Colors.white,
          leading: Icon(
            Icons.book,
            size: 32,
          ),
          onTap: onTap,
        ),
        Divider(
          color: Colors.white.withOpacity(0.7),
          thickness: 1,
        ),
      ],
    );
  }
}