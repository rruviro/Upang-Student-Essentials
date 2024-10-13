import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/SERVICES/bloc/student/student_bloc.dart';
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
<<<<<<< Updated upstream
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
=======
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider<StudentExtendedBloc>.value(
                        value: studBloc,
                        child: Bag(
                            studentProfile: widget.profile, Status: "ACTIVE"),
                      ),
                    ));
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Icon(Icons.backpack_outlined, size: 20, color: primary_color)
                  ),
>>>>>>> Stashed changes
                ),
                SizedBox(width: 20)
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
                    style: TextStyle(
                      fontSize: 15,
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
                          style: TextStyle(
                            fontSize: 15,
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
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'As bundle',
                                              style: TextStyle(
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

