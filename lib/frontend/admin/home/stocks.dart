// stateful

import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:lottie/lottie.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:use/backend/apiservice/adminApi/arepoimpl.dart";
import "package:use/backend/bloc/admin/admin_bloc.dart";
import "package:use/SERVICES/model/admin/BookStocks.dart";
import "package:use/SERVICES/model/admin/Stocks.dart";
import "package:use/backend/models/admin/Book.dart";
import "package:use/backend/models/admin/Stock.dart";
import "package:use/frontend/admin/home/uniform.dart";
import "package:use/frontend/admin/profile/profile.dart";
import 'package:file_picker/file_picker.dart';


import "../../colors/colors.dart";

class Stocks extends StatefulWidget {
  final int courseID;
  final String courseName;
  final String Department;
  final int departmentId;

  const Stocks(
      {super.key,
      required this.courseID,
      required this.courseName,
      required this.Department,
      required this.departmentId});
  @override
  State<Stocks> createState() => _StocksState();
}

final TextEditingController ProdController = TextEditingController();
final TextEditingController ProdMController = TextEditingController();
final TextEditingController ProdBController = TextEditingController();
final TextEditingController ProdBBController = TextEditingController();
final TextEditingController ProdBMController = TextEditingController();
final TextEditingController ProdBMMController = TextEditingController();

final TextEditingController BookNameController = TextEditingController();
final TextEditingController SubjectDescController = TextEditingController();
final TextEditingController stockNameController = TextEditingController();
// final int maxLength = 25;
// int _countProd = 0;

class _StocksState extends State<Stocks> {
  List<bool> _bottomSheetSelectedBooks = List.generate(5, (index) => false);
  List<bool> _containerSelectedBooks = List.generate(5, (index) => false);
  String _selectedYear = "First Year";

  File? _image;
  File? get image => _image;

  final adminRepository = AdminRepositoryImpl();

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> getCourse() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    context
        .read<AdminExtendedBloc>()
        .add(ShowStocksEvent(Course: widget.courseName));
    // ProdController.addListener(_updateCounter);
    // ProdMController.addListener(_updateCounter);
    // ProdBController.addListener(_updateCounter);
    // ProdBBController.addListener(_updateCounter);
    // ProdBMController.addListener(_updateCounter);
    // ProdBMMController.addListener(_updateCounter);
  }

  // void _updateCounter() {
  //   setState(() {
  //     _countProd = ProdController.text.length;
  //     _countProd = ProdMController.text.length;
  //     _countProd = ProdBController.text.length;
  //     _countProd = ProdBBController.text.length;
  //     _countProd = ProdBMController.text.length;
  //     _countProd = ProdBMMController.text.length;
  //   });
  // }

  @override
  void dispose() {
    // ProdController.removeListener(_updateCounter);
    // ProdController.dispose();
    super.dispose();
  }

  void _showAddUniformDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0),
          ),
          title: Container(
            height: 45,
            width: double.infinity,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'New Uniform Product',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Uniform Details',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          content: Container(
            height: 240,
            width: 200,
            child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _openImagePicker();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: primary_color,
                          borderRadius:
                              BorderRadius.circular(
                                  5)),
                      child: _image != null
                          ? Image.file(_image!,
                              fit: BoxFit.contain)
                          : Icon(
                              Icons
                                  .image_search_rounded,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller: stockNameController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: primary_color),
                        ),
                        hintText: 'Corporate Top',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        // suffix: Text(
                        //   '$_countProd/$maxLength',
                        //   style: TextStyle(
                        //     color: primary_color,
                        //     fontSize: 12,
                        //   ),
                        // ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),
                ]),
          ),
          actions: [
            // TEMPORARY COMMENT WAG TATANGGALIN!

            // GestureDetector(
            //   onTap: () async {
            //     // Pick the stock photo file
            //     FilePickerResult? result = await FilePicker.platform.pickFiles(
            //       type: FileType.image, // You can specify the type you want
            //     );
            //
            //     if (result != null) {
            //       // Get the selected file
            //       File stockPhotoFile = File(result.files.single.path!);
            //
            //       // Call createStock function with appropriate parameters
            //       await adminRepository.createStock(
            //         stockNameController.text, // Replace with actual stock name input if available
            //         stockPhotoFile, // Use the selected file
            //         widget.courseName, // Course name from your widget
            //         'Male', // Example gender, replace with actual input if available
            //         'Corporate', // Example type, replace with actual input if available
            //         'Pants', // Example body, replace with actual input if available
            //       );
            //
            //
            //       BlocProvider.of<AdminExtendedBloc>(context).add(ShowStocksEvent(
            //         Course: widget.courseName,
            //       ));
            //
            //     } else {
            //       // Handle the case when no file is selected
            //       print('No file selected.');
            //     }
            //   },
            //   child: Container(
            //     height: 30,
            //     width: 112,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(2),
            //       color: primary_color,
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Deploy',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
            ),
          ],

        );
      }
    );
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0),
          ),
          title: Container(
            height: 45,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Book Product',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Book Details',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w400),
                ),
              ],
            ),
          ),
          content: Container(
            height: 80,
            width: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller: BookNameController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  primary_color),
                        ),
                        hintText: 'SSP 012',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),


                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextFormField(
                      controller:
                          SubjectDescController,
                      decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey),
                        ),
                        focusedBorder:
                            UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  primary_color),
                        ),
                        hintText:
                            'Student Success Program',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType:
                          TextInputType.text,
                      textInputAction:
                          TextInputAction.done,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            23),
                      ],
                    ),
                  ),


                ]),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await adminRepository.createBook(
                    widget.courseName,
                    widget.Department,
                    BookNameController.text,
                    'NA 000',
                    SubjectDescController.text,
                    10,
                    0);
                BlocProvider.of<AdminExtendedBloc>(context).add(ShowStocksEvent(
                  Course: widget.courseName,
                ));
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 112,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(2),
                    color: primary_color),
                child: Center(
                  child: Text(
                    'Deploy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600),
                    ),
                  )),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
        listener: (context, state) {
      // if (state is UniformPageState) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => UniformAdmin(courseName: widget.courseName, Department: widget.Department,)));
      // } else if (state is UniformManagePageState) {
      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
      // } else if (state is NewDepartmentPageState) {
      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
      // }
    }, builder: (context, state) {
      if (state is StocksLoadingState) {
        return Center(
            child: Lottie.asset('assets/lottie/loading.json',
                height: 300, width: 380, fit: BoxFit.fill));
      } else if (state is StocksLoadedState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<AdminExtendedBloc>(context)
                    .add(ShowCoursesEvent(departmentID: widget.departmentId));
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
                      'Course : ${widget.courseName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 20,
                          child: Text(
                            'Uniform',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          top: -15,
                          right: 20,
                          child: IconButton(
                            icon: Icon(Icons.add, color: primary_color,),
                            onPressed: () {
                              _showAddUniformDialog();
                            },
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 10),
                    // STOCK LIST | START
                    Container(
                      height: 270,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal, 
                        children: [
                          Container(
                            child: state.stocks.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.shopping_bag,
                                      size: 50, color: Colors.grey),
                                )
                              : ItemList(
                                  stocks: state.stocks,
                                  courseName: widget.courseName,
                                  Department: widget.Department,
                                ),
                          ),
                        ]
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        child: Stack(children: [
                          Positioned(
                            top: -3,
                            left: 20,
                            child: Text(
                              'Books',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            top: -15,
                            right: 20,
                            child: IconButton(
                              icon: Icon(Icons.add, color: primary_color,),
                              onPressed: () {
                                _showAddBookDialog();
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
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
                                state.books.isEmpty
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.shopping_bag,
                                            size: 50, color: Colors.grey),
                                      )
                                    : BookList(books: state.books),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (state is StocksErrorState) {
        return Center(child: Text(state.error));
      } else {
        return Center(
            child: Lottie.asset('assets/lottie/loading.json',
                height: 300, width: 380, fit: BoxFit.fill));
      }
    }
        // }
        );
  }
}

class ItemList extends StatelessWidget {
  final List<Stock> stocks;
  final String courseName;
  final String Department;

  const ItemList({
    Key? key,
    required this.stocks,
    required this.courseName,
    required this.Department,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: stocks
          .map((stock) => ItemCard(
                stock: stock,
                courseName: courseName,
                Department: Department,
              ))
          .toList(),
    );
  }
}

class ItemCard extends StatefulWidget {
  final Stock stock;
  final String courseName;
  final String Department;

  const ItemCard({
    Key? key,
    required this.stock,
    required this.courseName,
    required this.Department,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  File? _image;
  File? get image => _image;

  final adminRepository = AdminRepositoryImpl();

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UniformAdmin(
                            courseName: widget.courseName,
                            Department: widget.Department,
                            stock: widget.stock,
                          )));
            },

            // image

            child: Container(
              height: 250,
              width: 250,
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.stock.photoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.stock.stockName} ${widget.stock.Body}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    right: 15,
                    child: InkWell(
                      onTap: (){
                        adminRepository.deleteStock(widget.stock.id);
                        Future.delayed(Duration(seconds: 1), () {
                          BlocProvider.of<AdminExtendedBloc>(context).add(ShowStocksEvent(
                              Course: widget.courseName
                          ));
                        });

                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red, // DELETE STOCK
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCardList extends StatelessWidget {
  final List<Stock> stocks;
  final String courseName;
  final String department;

  const ItemCardList({
    Key? key,
    required this.stocks,
    required this.courseName,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Set a height for the PageView
      child: PageView.builder(
        itemCount: stocks.length,
        controller: PageController(viewportFraction: 0.8), // Allows slight overlap
        itemBuilder: (context, index) {
          return ItemCard(
            stock: stocks[index],
            courseName: courseName,
            Department: department,
          );
        },
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;

  const BookList({Key? key, required this.books})
      : super(
            key:
                key); ////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      children: books
          .map((book) => BookCard(
                // courseID: 0,  ///////////////////////////////////////////////////////////
                visual: book,
                isSelected: false,
                onChanged: (bool? value) {},
              ))
          .toList(),
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
    // required int courseID
  }) : super(key: key);
  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isChecked = false;
  File? _image;
  File? get image => _image;

  final adminRepository = AdminRepositoryImpl();

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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
                fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.visual.SubjectDesc,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                  height: 5), // Space between subtitle and Stock/Reserved
              // Stock and Reserved information below subtitle
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Stock: ${widget.visual.Stock}',
                    style: TextStyle(
                      color:
                          widget.visual.Stock > 0 ? Colors.white : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 3), // Space between Stock and divider

                  // Proper Vertical Divider with height and color
                  Container(
                    height: 15, // Set height for the divider
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),

                  SizedBox(width: 5), // Space between divider and Reserved

                  Text(
                    'Reserved: ${widget.visual.Reserved}',
                    style: TextStyle(
                      color: widget.visual.Reserved > 0
                          ? Colors.white
                          : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          iconColor: Colors.white,
          leading: Icon(
            Icons.book,
            size: 32,
            color: Colors.white,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _showUpdateUniformDialog(context, widget.visual);
                },
                icon: Icon(
                  Icons.dashboard_customize_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  adminRepository.deleteBook(widget.visual.id);
                  Future.delayed(Duration(seconds: 1), () {
                    BlocProvider.of<AdminExtendedBloc>(context).add(ShowStocksEvent(
                      Course: widget.visual.Course
                    ));
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red, //test
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white.withOpacity(0.5),
          thickness: 1,
          indent: 16,
          endIndent: 16,
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

Future<void> _showUpdateUniformDialog(BuildContext context, Book book) async {
  TextEditingController stockController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Update Book Stock',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Name: ${book.BookName}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              TextField(
                controller: stockController,
                decoration: InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              if (stockController.text.isNotEmpty) {
                BlocProvider.of<AdminExtendedBloc>(context).add(
                  bookreservefirst(
                    book.BookName,
                    int.parse(stockController.text),
                  ),
                );
                BlocProvider.of<AdminExtendedBloc>(context).add(ShowStocksEvent(
                  Course: book.Course,
                ));
                Navigator.of(context).pop();
              } else {
                print('Stock input is empty');
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.greenAccent,
            ),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
