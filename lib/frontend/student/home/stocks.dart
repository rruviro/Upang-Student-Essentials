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
  // String _selectedYear = "First Year"; // TINANGGAL KO YUNG YEARS SA APPBAR
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
                                BookList(books: state.books),
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
  const BookList({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: books.map((book) => BookCard(visual: book, isSelected: false, onChanged: (bool? value) {},)).toList(),
    );
  }
}
class BookCard extends StatefulWidget {
  final Book visual;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  const BookCard({
    Key? key,
    required this.visual,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);
  @override
  State<BookCard> createState() => _BookCardState();
}
class _BookCardState extends State<BookCard> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = widget.isSelected;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.visual.BookName,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.visual.SubjectDesc,
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
          trailing: CustomCircularCheckbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
                widget.onChanged?.call(isChecked);
              });
            },
          ),
        ),
        Divider(
          color: Colors.white.withOpacity(0.7),
          thickness: 1,
        ),
      ],
    );
  }
}

class CustomCircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCircularCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: value
            ? Icon(
          Icons.check,
          color: Colors.black,
          size: 16,
        )
            : null,
      ),
    );
  }
}