import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/SERVICES/model/student/BookStocks.dart';
import 'package:use/SERVICES/model/student/Stocks.dart';
import 'package:use/frontend/student/home/home.dart';
import 'package:use/frontend/student/widgets/home/stocks.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
  
}

class _StocksState extends State<Stocks> {
  List<bool> _bottomSheetSelectedBooks = List.generate(5, (index) => false);
  List<bool> _containerSelectedBooks = List.generate(5, (index) => false);
  String _selectedYear = "First Year";

  @override
  Widget build(BuildContext context) {
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
                  'Stocks',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Course : ',
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
              children: [
                Text(
                  'Year',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                SizedBox(height: 4),
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: SizedBox(
                    width: 100,
                    height: 20,
                    child: DropdownButton<String>(
                      value: _selectedYear,
                      dropdownColor: Color(0xFF0EAA72),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedYear = newValue!;
                        });
                      },
                      items: <String>[
                        'First Year',
                        'Second Year',
                        'Third Year',
                        'Fourth Year'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            width: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Uniform',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 270,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: stocks_widget (
                          list : products
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Books',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFF0EAA72),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5,
                              offset: Offset(1, 5),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Center(
                                        child: Container(
                                          height: 5,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF0EAA72),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            AllBookList(
                                              list: BookProducts
                                            )  
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.apps,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 17.5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'All Books',
                                              style: GoogleFonts.inter(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'As bundle',
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                color: Colors.white.withOpacity(0.7),
                                                fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Color(0xFF0EAA72),
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
                              BookList(bookProducts: BookProducts)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final List<BookStocks> bookProducts;
  const BookList({Key? key, required this.bookProducts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookProducts
      .map((e) => BookCard(
        visual: e,
        isSelected: false,
        onChanged: (bool? value) {},
      ))
      .toList(),
    );
  }
}
class BookCard extends StatefulWidget {
  final BookStocks visual;
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
            widget.visual.subjectCode,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.visual.bookName,
            style: TextStyle(
              fontSize: 11,
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

class AllBookList extends StatelessWidget {
  final List<BookStocks> list;
  const AllBookList({Key? key, required this.list}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: list
        .map((e) => AllBooksCard(
            visual: e,
          ))
        .toList(),
    );
  }
}
class AllBooksCard extends StatelessWidget {
  final BookStocks visual;
  const AllBooksCard({Key? key, required this.visual}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            visual.subjectCode,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF0EAA72),
            ),
          ),
          subtitle: Text(
            visual.bookName,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF0EAA72).withOpacity(0.7),
            ),
          ),
          iconColor: Color(0xFF0EAA72),
          leading: Icon(
            Icons.book,
            size: 32,
          ),
        ),
        Divider(
          color: Color(0xFF0EAA72).withOpacity(0.7),
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
