import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/frontend/student/profile/transaction.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

import '../colors/colors.dart';

class Bag extends StatefulWidget {
  const Bag({
    Key? key,
    required this.studentProfile,
    required this.Status,
  }) : super(key: key);

  final StudentProfile studentProfile;
  final String Status;

  @override
  State<Bag> createState() => BagState();
}

class BagState extends State<Bag> {
  bool _showLoading = true;
  List<int> checkedBookIds = [];
  List<int> checkedItemIds = [];

  bool isAllBooksChecked = false;
  bool isAllItemsChecked = false;

  Map<int, StudentBagBook> bookMap = {};
  Map<int, StudentBagItem> itemMap = {};

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showLoading = false;
      });
    });

    context.read<StudentExtendedBloc>().add(
          studentBagItem(widget.studentProfile.id, widget.Status),
        );

    context.read<StudentExtendedBloc>().add(
          studentBagBook(widget.studentProfile.id, widget.Status),
        );
  }

  Future<void> refreshData() async {
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        _showLoading = false;
      });
    });
    print("asd");
    context.read<StudentExtendedBloc>().add(
          studentBagItem(widget.studentProfile.id, widget.Status),
        );

    context.read<StudentExtendedBloc>().add(
          studentBagBook(widget.studentProfile.id, widget.Status),
        );
  }

  Future<bool> _onPop() async {
    Navigator.pop(context, false);
    return false;
  }

  void updateCheckedBookIds(int id, bool isChecked) {
    setState(() {
      if (isChecked) {
        checkedBookIds.add(id);
      } else {
        checkedBookIds.remove(id);
      }
    });
  }

  void updateCheckedItemIds(int id, bool isChecked) {
    setState(() {
      if (isChecked) {
        checkedItemIds.add(id);
      } else {
        checkedItemIds.remove(id);
      }
    });
  }

  void toggleSelectAllBooks(bool? value, List<StudentBagBook> studentBagBooks) {
    setState(() {
      isAllBooksChecked = value ?? false;
      if (isAllBooksChecked) {
        checkedBookIds = studentBagBooks.map((book) => book.id).toList();
      } else {
        checkedBookIds.clear();
      }
    });
  }

  void toggleSelectAllItems(bool? value, List<StudentBagItem> studentBagItems) {
    setState(() {
      isAllItemsChecked = value ?? false;
      if (isAllItemsChecked) {
        checkedItemIds = studentBagItems.map((item) => item.id).toList();
      } else {
        checkedItemIds.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
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
                child: Text(
                  'Backpack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<StudentExtendedBloc, StudentExtendedState>(
            builder: (context, state) {
              if (_showLoading) {
                print('loading...');
                return Center(child: CircularProgressIndicator());
              }
              if (state is BookDataDeleted || state is ItemDataDeleted) {
                refreshData();
                print(state);
              }
              if (state is StudentBagCombinedLoadSuccessState) {
                bookMap = {
                  for (var book in state.studentBagBooks) book.id: book
                };
                itemMap = {
                  for (var item in state.studentBagItems) item.id: item
                };
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Books',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8.0),
                            BookList(
                              status: state.studentBagBooks,
                              refresh: refreshData,
                              onCheckboxChanged: updateCheckedBookIds,
                              checkedBookIds: checkedBookIds,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uniform',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8.0),
                            ItemList(
                              status: state.studentBagItems,
                              refresh: refreshData,
                              onCheckboxChanged: updateCheckedItemIds,
                              checkedItemIds: checkedItemIds,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is StudentBagItemLoadingState ||
                  state is StudentBagBookLoadingState) {
                print("loading: $state");
                return Center(child: CircularProgressIndicator());
              } else if (state is StudentBagItemErrorState ||
                  state is StudentBagBookErrorState) {
                print("error: $state");
                return Center(child: CircularProgressIndicator());
              } else {
                print("error");
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          bottomNavigationBar: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 70,
            color: primary_color,
            child: Stack(
              children: [
                Positioned(
                  top: 15,
                  bottom: 15,
                  left: 20,
                  child: Container(
                    width: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Transform.scale(
                            scale: 0.99,
                            child: Checkbox(
                              value: isAllItemsChecked,
                              onChanged: (bool? value) {
                                final state =
                                    context.read<StudentExtendedBloc>().state;
                                toggleSelectAllItems(
                                    value,
                                    (state as StudentBagCombinedLoadSuccessState)
                                        .studentBagItems);
                                toggleSelectAllBooks(
                                    value, (state).studentBagBooks);
                              },
                              activeColor: Colors.white,
                              checkColor: primary_color,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Center(
                          child: Text(
                            'Select All Items',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  bottom: 15,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print(
                              "Checked Book IDs: ${checkedBookIds.join(', ')}");
                          if (checkedBookIds.length == 0 &&
                              checkedItemIds.length == 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    title: Container(
                                      height: 100,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    content: Container(
                                      height: 20,
                                      child: Center(
                                        child: Text(
                                          'Please select an item to request.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            int stocks = 0;
                            if (checkedBookIds.isNotEmpty) {
                              for (var bookId in checkedBookIds) {
                                var book = bookMap[
                                    bookId]; // Get the corresponding book object
                                context.read<StudentExtendedBloc>().add(
                                    reserveorclaimBook(
                                        bookId, 'Request', stocks));

                                if (stocks == 0) {
                                  context.read<StudentExtendedBloc>().add(
                                        createNotification(
                                          widget.studentProfile.id,
                                          'The Book "${book?.code ?? 'Unknown'}" you\'ve requested is now RESERVED.',
                                        ),
                                      );
                                } else {
                                  context.read<StudentExtendedBloc>().add(
                                        createNotification(
                                          widget.studentProfile.id,
                                          'The Book "${book?.code ?? 'Unknown'}" you\'ve requested is now ready to be CLAIMED.',
                                        ),
                                      );
                                }
                              }
                            }

                            if (checkedItemIds.isNotEmpty) {
                              for (var itemId in checkedItemIds) {
                                var item = itemMap[
                                    itemId]; // Get the corresponding item object
                                context
                                    .read<StudentExtendedBloc>()
                                    .add(reserveorclaimItem(itemId, 'Request'));

                                if (stocks == 0) {
                                  context.read<StudentExtendedBloc>().add(
                                        createNotification(
                                          widget.studentProfile.id,
                                          'The Item "${item?.code ?? 'Unknown'}" you\'ve requested is now RESERVED.',
                                        ),
                                      );
                                } else {
                                  context.read<StudentExtendedBloc>().add(
                                        createNotification(
                                          widget.studentProfile.id,
                                          'The Item "${item?.code ?? 'Unknown'}" you\'ve requested is now ready to be CLAIMED.',
                                        ),
                                      );
                                }
                              }
                            }
                            checkedBookIds.clear();
                            checkedItemIds.clear();
                            setState(() {
                              isAllItemsChecked = false;
                            });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  title: Container(
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: primary_color,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                  content: Container(
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        'Successful, Check your order in your transaction now.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              final result = await Navigator
                                                  .pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Transaction(
                                                          page: 1,
                                                          studentProfile: widget
                                                              .studentProfile,
                                                          status: 'Request'),
                                                ),
                                              );
                                              if (result == true) {
                                                print(result);
                                                refreshData();
                                              } else {
                                                print(result);
                                                refreshData();
                                              }
                                            },
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                color: primary_color,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Transaction',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
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
                                              Navigator.pop(context);
                                              refreshData();
                                            },
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                color: Color.fromARGB(
                                                    192, 14, 170, 113),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Close',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        190, 255, 255, 255),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Request',
                              style: TextStyle(
                                color: primary_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ItemList extends StatelessWidget {
  final List<StudentBagItem> status;
  final Future<void> Function() refresh;
  final Function(int id, bool isChecked) onCheckboxChanged;
  final List<int> checkedItemIds;
  const ItemList(
      {Key? key,
      required this.status,
      required this.refresh,
      required this.onCheckboxChanged,
      required this.checkedItemIds})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map((e) => ItemCard(
                item: e,
                onpressed: () async {
                  context.read<StudentExtendedBloc>().add(
                        deleteItemData(e.id),
                      );
                  await refresh;
                },
                onCheckboxChanged: onCheckboxChanged,
                isChecked: checkedItemIds.contains(e.id),
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatefulWidget {
  final StudentBagItem item;
  final VoidCallback onpressed;
  final Function(int id, bool isChecked) onCheckboxChanged;
  final bool isChecked; // Add this parameter
  const ItemCard(
      {Key? key,
      required this.item,
      required this.onpressed,
      required this.onCheckboxChanged,
      required this.isChecked})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 15.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary_color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: primary_color,
                    ),
                    child: Image.asset(
                      'assets/b19d1b570a8d62ff56f4f351e389c2db.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.gender,
                          style: TextStyle(
                            color: primary_color,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Gender : ' + widget.item.gender,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Course : ' + widget.item.course,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Size : ' + widget.item.size,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 0.99,
                child: Checkbox(
                  value: widget.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.onCheckboxChanged(widget.item.id, value!);
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: primary_color,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 14),
                child: Center(
                  child: Text(
                    widget.item.department,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: Container(
            child: IconButton(
              onPressed: widget.onpressed,
              icon: Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BookList extends StatelessWidget {
  final List<StudentBagBook> status;
  final Future<void> Function() refresh;
  final Function(int id, bool isChecked) onCheckboxChanged;
  final List<int> checkedBookIds;

  const BookList({
    Key? key,
    required this.status,
    required this.refresh,
    required this.onCheckboxChanged,
    required this.checkedBookIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: status
          .map((e) => BookCard(
              book: e,
              onpressed: () async {
                context.read<StudentExtendedBloc>().add(deleteBookData(e.id));
                await refresh();
              },
              onCheckboxChanged: onCheckboxChanged,
              isChecked: checkedBookIds.contains(e.id)))
          .toList(),
    );
  }
}

class BookCard extends StatefulWidget {
  final StudentBagBook book;
  final VoidCallback onpressed;
  final Function(int id, bool isChecked) onCheckboxChanged;
  final bool isChecked; // Add this parameter
  const BookCard(
      {Key? key,
      required this.book,
      required this.onpressed,
      required this.onCheckboxChanged,
      required this.isChecked})
      : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 15.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(1, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary_color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: primary_color,
                    ),
                    child: Image.asset(
                      'assets/b19d1b570a8d62ff56f4f351e389c2db.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.bookName,
                          style: TextStyle(
                            color: primary_color,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Subject Code : ' + widget.book.subjectCode,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          widget.book.subjectDesc,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 0.99,
                child: Checkbox(
                  value: widget.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.onCheckboxChanged(widget.book.id, value!);
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: primary_color,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 14),
                child: Center(
                  child: Text(
                    "BOOK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: Container(
            child: IconButton(
              onPressed: widget.onpressed,
              icon: Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
