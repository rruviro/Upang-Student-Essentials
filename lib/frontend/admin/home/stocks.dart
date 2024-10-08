// stateful

import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:use/backend/bloc/admin/admin_bloc.dart";
import "package:use/SERVICES/model/admin/BookStocks.dart";
import "package:use/SERVICES/model/admin/Stocks.dart";
import "package:use/frontend/admin/home/uniform.dart";
import "package:use/frontend/admin/profile/profile.dart";

import "../../colors/colors.dart";

class Stocks extends StatefulWidget {
  final int courseID;
  final String courseName;

  const Stocks({super.key, required this.courseID, required this.courseName});
  @override
  State<Stocks> createState() => _StocksState();
}

final TextEditingController ProdController = TextEditingController();
final TextEditingController ProdMController = TextEditingController();
final TextEditingController ProdBController = TextEditingController();
final TextEditingController ProdBBController = TextEditingController();
final TextEditingController ProdBMController = TextEditingController();
final TextEditingController ProdBMMController = TextEditingController();
final int maxLength = 25;
int _countProd = 0;

class _StocksState extends State<Stocks> {
  List<bool> _bottomSheetSelectedBooks = List.generate(5, (index) => false);
  List<bool> _containerSelectedBooks = List.generate(5, (index) => false);
  String _selectedYear = "First Year";

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ProdController.addListener(_updateCounter);
    ProdMController.addListener(_updateCounter);
    ProdBController.addListener(_updateCounter);
    ProdBBController.addListener(_updateCounter);
    ProdBMController.addListener(_updateCounter);
    ProdBMMController.addListener(_updateCounter);
  }

  void _updateCounter() {
    setState(() {
      _countProd = ProdController.text.length;
      _countProd = ProdMController.text.length;
      _countProd = ProdBController.text.length;
      _countProd = ProdBBController.text.length;
      _countProd = ProdBMController.text.length;
      _countProd = ProdBMMController.text.length;
    });
  }

  @override
  void dispose() {
    // ProdController.removeListener(_updateCounter);
    // ProdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
        bloc: adminBloc,
        listenWhen: (previous, current) => current is AdminActionState,
        buildWhen: (previous, current) => current is! AdminActionState,
        listener: (context, state) {
          if (state is UniformPageState) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
          } else if (state is UniformManagePageState) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
          } else if (state is NewDepartmentPageState) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => unifrom()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AdminLoadingState():
              return CircularProgressIndicator();
            default:
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
                            'Course : ${widget.courseName}',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
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
                            child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Text(
                                      'Uniform',
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 20,
                                    child: InkWell(
                                      onTap:() {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                                title: Container(
                                                  height: 45,
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'New Uniform Product',
                                                        style: GoogleFonts.inter(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        'Uniform Details',
                                                        style: GoogleFonts.inter(
                                                            color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                content: Container(
                                                  height: 240,
                                                  width: 200,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            _openImagePicker();
                                                          },
                                                          child: Container(
                                                            height: 200,
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                                color: primary_color,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: _image != null
                                                                ? Image.file(
                                                                _image!,
                                                                fit: BoxFit.contain
                                                            )
                                                                : Icon(
                                                              Icons.image_search_rounded,color:
                                                            Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: double.infinity,
                                                          child: TextFormField(
                                                            controller: ProdController,
                                                            decoration: InputDecoration(
                                                              border: UnderlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey),
                                                              ),
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(color: primary_color),
                                                              ),
                                                              hintText: 'Corporate Top',
                                                              hintStyle: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                              suffix: Text(
                                                                '$_countProd/$maxLength',
                                                                style: TextStyle(
                                                                  color: primary_color,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              suffixStyle: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.text,
                                                            textInputAction: TextInputAction.done,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(23),
                                                            ],
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                actions: [
                                                  GestureDetector(
                                                    onTap: (){
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 112,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                          color: primary_color
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Deploy',
                                                          style: GoogleFonts.inter(
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        height: 30,
                                                        width: 112,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(2),
                                                            color: Color.fromARGB(192, 14, 170, 113)
                                                        ),
                                                        child: Center(
                                                          child:Text(
                                                            'Cancel',
                                                            style: GoogleFonts.inter(
                                                                color: const Color.fromARGB(190, 255, 255, 255),
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                        );
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: primary_color,
                                      ),
                                    ),
                                  ),
                                ]
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
                                    child: ItemList(
                                        list : products
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
                              child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 20,
                                      child: Text(
                                        'Books',
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 20,
                                      child: InkWell(
                                        onTap:() {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                  ),
                                                  title: Container(
                                                    height: 45,
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'New Book Product',
                                                          style: GoogleFonts.inter(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          'Book Details',
                                                          style: GoogleFonts.inter(
                                                              color: Colors.grey,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  content: Container(
                                                    height: 280,
                                                    width: 200,
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              _openImagePicker();
                                                            },
                                                            child: Container(
                                                              height: 200,
                                                              width: double.infinity,
                                                              decoration: BoxDecoration(
                                                                  color: primary_color,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: _image != null
                                                                  ? Image.file(
                                                                  _image!,
                                                                  fit: BoxFit.contain
                                                              )
                                                                  : Icon(
                                                                Icons.image_search_rounded,color:
                                                              Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: double.infinity,
                                                            child: TextFormField(
                                                              controller: ProdBController,
                                                              decoration: InputDecoration(
                                                                border: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: primary_color),
                                                                ),
                                                                hintText: 'SSP 012',
                                                                hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                suffix: Text(
                                                                  '$_countProd/$maxLength',
                                                                  style: TextStyle(
                                                                    color: primary_color,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                                suffixStyle: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              keyboardType: TextInputType.text,
                                                              textInputAction: TextInputAction.done,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(23),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: double.infinity,
                                                            child: TextFormField(
                                                              controller: ProdBBController,
                                                              decoration: InputDecoration(
                                                                border: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.grey),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: primary_color),
                                                                ),
                                                                hintText: 'Student Success Program',
                                                                hintStyle: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                suffix: Text(
                                                                  '$_countProd/$maxLength',
                                                                  style: TextStyle(
                                                                    color: primary_color,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                                suffixStyle: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              keyboardType: TextInputType.text,
                                                              textInputAction: TextInputAction.done,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(23),
                                                              ],
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                  actions: [
                                                    GestureDetector(
                                                      onTap: (){
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 112,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(2),
                                                            color: primary_color
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Deploy',
                                                            style: GoogleFonts.inter(
                                                                color: Colors.white,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: 112,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(2),
                                                              color: Color.fromARGB(192, 14, 170, 113)
                                                          ),
                                                          child: Center(
                                                            child:Text(
                                                              'Cancel',
                                                              style: GoogleFonts.inter(
                                                                  color: const Color.fromARGB(190, 255, 255, 255),
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w600
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                          );
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: primary_color,
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    height: 70,
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
                                                          color: primary_color,
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
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                        Text(
                                                          'As bundle',
                                                          style: GoogleFonts.inter(
                                                              fontSize: 10,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w300
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
    );
  }
}

class ItemList extends StatelessWidget {
  final List<stocks> list;
  const ItemList({Key? key, required this.list}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: list
          .map((e) => ItemCard(
        visual: e,
      ))
          .toList(),
    );
  }
}

class ItemCard extends StatefulWidget {
  final stocks visual;
  const ItemCard({Key? key, required this.visual}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
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
            onTap: (){
              adminBloc.add(UniformPageEvent());
            },
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
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        widget.visual.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.visual.product,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Stocks : ' + widget.visual.stock,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 85,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Color.fromARGB(227, 255, 255, 255)
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          title: Container(
                            height: 45,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manage Uniform Product',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Uniform Details',
                                  style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: Container(
                            height: 240,
                            width: 200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _openImagePicker();
                                    },
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: primary_color,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: _image != null
                                          ? Image.file(
                                          _image!,
                                          fit: BoxFit.contain
                                      )
                                          : Image.asset(
                                        widget.visual.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: ProdMController,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: primary_color),
                                        ),
                                        hintText: 'Corporate Top',
                                        hintStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffix: Text(
                                          '$_countProd/$maxLength',
                                          style: TextStyle(
                                            color: primary_color,
                                            fontSize: 12,
                                          ),
                                        ),
                                        suffixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(23),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: (){
                              },
                              child: Container(
                                height: 30,
                                width: 112,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: primary_color
                                ),
                                child: Center(
                                  child: Text(
                                    'Update',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 30,
                                  width: 112,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Color.fromARGB(192, 14, 170, 113)
                                  ),
                                  child: Center(
                                    child:Text(
                                      'Cancel',
                                      style: GoogleFonts.inter(
                                          color: const Color.fromARGB(190, 255, 255, 255),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        );
                      }
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Manage',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 10.5,
                            color: primary_color,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: primary_color,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final List<BookStocks> bookProducts;
  const BookList({Key? key, required this.bookProducts}) : super(key: key); ////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookProducts
          .map((e) => BookCard(
        courseID: 0,  ///////////////////////////////////////////////////////////
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
    required int courseID
  }) : super(key: key);
  @override
  State<BookCard> createState() => _BookCardState();
}
class _BookCardState extends State<BookCard> {
  bool isChecked = false;
  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          title: Container(
                            height: 45,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manage Book Product',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Book Details',
                                  style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: Container(
                            height: 280,
                            width: 200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _openImagePicker();
                                    },
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: primary_color,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: _image != null
                                          ? Image.file(
                                          _image!,
                                          fit: BoxFit.contain
                                      )
                                          : Icon(
                                        Icons.image_search_rounded,color:
                                      Colors.white,
                                      ),
                                      //   Image.asset(
                                      //     widget.visual.image,
                                      //     fit: BoxFit.contain,
                                      // )
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: ProdBMController,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: primary_color),
                                        ),
                                        hintText: 'SSP 012',
                                        hintStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffix: Text(
                                          '$_countProd/$maxLength',
                                          style: TextStyle(
                                            color: primary_color,
                                            fontSize: 12,
                                          ),
                                        ),
                                        suffixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(23),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: ProdBMMController,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: primary_color),
                                        ),
                                        hintText: 'Student Success Program',
                                        hintStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffix: Text(
                                          '$_countProd/$maxLength',
                                          style: TextStyle(
                                            color: primary_color,
                                            fontSize: 12,
                                          ),
                                        ),
                                        suffixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(23),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: (){
                              },
                              child: Container(
                                height: 30,
                                width: 112,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: primary_color
                                ),
                                child: Center(
                                  child: Text(
                                    'Deploy',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 30,
                                  width: 112,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Color.fromARGB(192, 14, 170, 113)
                                  ),
                                  child: Center(
                                    child:Text(
                                      'Cancel',
                                      style: GoogleFonts.inter(
                                          color: const Color.fromARGB(190, 255, 255, 255),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        );
                      }
                  );
                },
                icon: Icon(
                  Icons.dashboard_customize_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
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
              color: primary_color,
            ),
          ),
          subtitle: Text(
            visual.bookName,
            style: TextStyle(
              fontSize: 11,
              color: primary_color.withOpacity(0.7),
            ),
          ),
          iconColor: primary_color,
          leading: Icon(
            Icons.book,
            size: 32,
          ),
        ),
        Divider(
          color: primary_color.withOpacity(0.7),
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