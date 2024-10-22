import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:use/backend/apiservice/adminApi/arepoimpl.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/frontend/colors/colors.dart';

class UniformAdmin extends StatefulWidget {
  final String courseName;
  final String Department;
  final Stock stock;

  const UniformAdmin({
    super.key,
    required this.courseName,
    required this.Department,
    required this.stock,
  });

  @override
  State<UniformAdmin> createState() => _UniformAdminState();
}

class _UniformAdminState extends State<UniformAdmin> {
  List<Map<String, String>> measures = [
    {"size": "XS", "chest": "17.5", "hips": "25.5"},
    {"size": "S", "chest": "18.5", "hips": "26.5"},
    {"size": "M", "chest": "19.5", "hips": "27.5"},
    {"size": "L", "chest": "20.5", "hips": "28.5"},
    {"size": "XL", "chest": "21.5", "hips": "29.5"},
    {"size": "XXL", "chest": "22.5", "hips": "30.5"},
  ];

  List<File> _images = [];
  List<bool> _selectedImages = [];
  bool _isDeleteMode = false;

  // final TextEditingController DepartmentController = TextEditingController();
  // final TextEditingController CourseController = TextEditingController();
  // final TextEditingController GenderController = TextEditingController();
  // final TextEditingController TypeController = TextEditingController();
  // final TextEditingController BodyController = TextEditingController();
  final TextEditingController SizeController = TextEditingController();
  // final TextEditingController StockController = TextEditingController();
  // final TextEditingController ReservedController = TextEditingController();

  final adminRepository = AdminRepositoryImpl();

  void _deleteSelectedImages() {
    setState(() {
      if (_images.isEmpty || _selectedImages.isEmpty) return;

      for (int i = _images.length - 1; i >= 0; i--) {
        if (_selectedImages[i]) {
          _images.removeAt(i);
          _selectedImages.removeAt(i);
        }
      }
    });
  }

  void _showAddSizeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Size',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Enter uniform size (e.g., S, M, L)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            ],
          ),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  child: TextFormField(
                    controller: SizeController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primary_color,
                          ),
                        ),
                        hintText: 'Enter Size',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
            TextButton(
              onPressed: () async {
                await adminRepository.createUniform(
                  widget.Department,
                  widget.courseName,
                  widget.stock.Gender,
                  widget.stock.Type,
                  widget.stock.Body,
                  SizeController.text,
                  10,
                  0,
                );
                BlocProvider.of<AdminExtendedBloc>(context).add(
                    ShowUniformsEvent(widget.courseName, widget.stock.Gender,
                        widget.stock.Type, widget.stock.Body));
                Navigator.pop(context);
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }

  bool _showLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        _showLoading = false;
      });
    });
    BlocProvider.of<AdminExtendedBloc>(context).add(ShowUniformsEvent(
        widget.courseName,
        widget.stock.Gender,
        widget.stock.Type,
        widget.stock.Body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary_color,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<AdminExtendedBloc>()
                  .add(ShowStocksEvent(Course: widget.courseName));
            },
          ),
          title: Transform.translate(
            offset: const Offset(-15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uniform',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Course: ${widget.courseName} ${widget.stock.stockName}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (_showLoading) {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json',
                      height: 300, width: 380, fit: BoxFit.fill));
            }
            if (state is UniformsLoadingState) {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json',
                      height: 300, width: 380, fit: BoxFit.fill));
            } else if (state is UniformsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: primary_color,
                        toolbarHeight: 300,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            color: primary_color,
                          ),
                          child: Center(
                            child: ClipRect(
                              child: Image.network(
                                widget.stock.photoUrl,
                                width: 300,
                                height: 300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.stock.stockName}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size Stocks",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  // add button

                                  IconButton(
                                    icon: Icon(Icons.add),
                                    color: primary_color,
                                    onPressed: () {
                                      _showAddSizeDialog();
                                    },
                                  )

                                  //
                                ],
                              ),
                              SizedBox(height: 20),
                              uniformsList(state.uniforms),
                              SizedBox(height: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Size Chart",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "See what size best suits you.",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 330,
                            width: 460,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Expanded(
                                    child: Center(child: Text("SIZE")),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(child: Text("CHEST")),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(child: Text("HIPS")),
                                  ),
                                ),
                              ],
                              rows: measures.map((measure) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                          child: Text(measure["size"] ?? "")),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(measure["chest"] ?? "")),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(measure["hips"] ?? "")),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else if (state is UniformsErrorState) {
              return Center(child: Text(state.error));
            } else {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json',
                      height: 300, width: 380, fit: BoxFit.fill));
            }
          },
        ));
  }

  Widget slides(BuildContext context) {
    List<String> imageUrls = ['assets/bsit.png', 'assets/uniuni.png'];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider(
        items: imageUrls.map((url) {
          return Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: primary_color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                url,
                fit: BoxFit.fill,
                width: 200,
                height: 200,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 600),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  Widget uniformsList(List<Uniform> uniforms) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: uniforms.asMap().entries.map((entry) {
          int index = entry.key;
          Uniform uniform = entry.value;

          double leftPadding = index == 0 ? 0 : 5;
          double rightPadding = index == uniforms.length - 1 ? 0 : 5;

          return Padding(
            padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 8,
              child: Container(
                width:
                    MediaQuery.of(context).size.width * 0.4, // Adjusted to 40%
                height: 50,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.10, // 10%
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: primary_color,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${uniform.Size}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Align to start
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Stock: ${uniform.Stock}',
                                style: TextStyle(
                                  color: uniform.Stock > 0
                                      ? primary_color
                                      : Colors.redAccent,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Reserved: ${uniform.Reserved}',
                                style: TextStyle(
                                  color: uniform.Reserved > 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              _showUpdateUniformDialog(context, uniform);
                            },
                            icon: Icon(
                              Icons.add,
                              color: primary_color,
                            ),
                          ),
                          SizedBox(width: 4), // Adjust spacing
                          IconButton(
                            onPressed: () {
                              adminRepository.deleteUniform(uniform.id);
                              Future.delayed(Duration(seconds: 1), () {
                                BlocProvider.of<AdminExtendedBloc>(context).add(
                                    ShowUniformsEvent(
                                        widget.courseName,
                                        widget.stock.Gender,
                                        widget.stock.Type,
                                        widget.stock.Body));
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              color: primary_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _showUpdateUniformDialog(
      BuildContext context, Uniform uniform) async {
    TextEditingController stockController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Update Uniform Stock',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uniform Size: ${uniform.Size}',
                  style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),

                Container(
                  height: 40,
                  width: double.infinity,
                  child: TextFormField(
                    controller: stockController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: primary_color,
                        )),
                        hintText: 'Stock',
                        hintStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        suffixStyle:
                            TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                )

                // TextField(
                //   controller: stockController,
                //   decoration: InputDecoration(
                //     labelText: 'Stock',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     filled: true,
                //     fillColor: Colors.grey[200],
                //   ),
                //   keyboardType: TextInputType.number,
                // ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
            TextButton(
              onPressed: () {
                if (stockController.text.isNotEmpty) {
                  // Add the event to Bloc and update stock
                  BlocProvider.of<AdminExtendedBloc>(context).add(
                    itemreservefirst(
                      int.parse(stockController.text),
                      uniform.Course,
                      uniform.Gender,
                      uniform.Type,
                      uniform.Body,
                      uniform.Size,
                    ),
                  );

                  // Close the dialog
                  Navigator.of(context).pop();
                } else {
                  print('Stock input is empty');
                }
              },
              child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: primary_color),
                  child: Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }
}
