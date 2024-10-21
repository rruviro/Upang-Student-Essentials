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
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Add Size',
            style: TextStyle(
              color: primary_color,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: SizeController,
                decoration: InputDecoration(
                  labelText: 'Enter size',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.grey),
              ),
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
              child: Text(
                'Add',
                style: TextStyle(
                    color: primary_color), // Primary color for add button
              ),
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
    return BlocConsumer<AdminExtendedBloc, AdminExtendedState>(
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
            body: SingleChildScrollView(
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

                  // Container(
                  //   padding: EdgeInsets.all(20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             "${_images.length + 2} Images",
                  //             style: TextStyle(fontSize: 10),
                  //           ),
                  //           if (_images.isNotEmpty)
                  //             IconButton(
                  //               icon: Icon(
                  //                 _isDeleteMode ? Icons.check : Icons.delete,
                  //                 color:
                  //                     _isDeleteMode ? Colors.green : Colors.red,
                  //               ),
                  //               onPressed: () {
                  //                 if (_isDeleteMode) {
                  //                   _showDeleteConfirmation();
                  //                 } else {
                  //                   _toggleDeleteMode();
                  //                 }
                  //               },
                  //             ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 8),
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 color: Color(0xFFD9D9D9),
                  //               ),
                  //               padding: EdgeInsets.all(8),
                  //               child: Image.asset(
                  //                 'assets/bsit.png',
                  //                 height: 60,
                  //                 width: 30,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //             SizedBox(width: 8),
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 color: Color(0xFFD9D9D9),
                  //               ),
                  //               padding: EdgeInsets.all(8),
                  //               child: Image.asset(
                  //                 'assets/uniuni.png',
                  //                 height: 60,
                  //                 width: 30,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //             SizedBox(width: 8),
                  //             ..._images.asMap().entries.map((entry) {
                  //               int index = entry.key;
                  //               File image = entry.value;
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                   if (_isDeleteMode) {
                  //                     _selectImage(index);
                  //                   }
                  //                 },
                  //                 child: Stack(
                  //                   children: [
                  //                     Container(
                  //                       margin: EdgeInsets.only(right: 10),
                  //                       decoration: BoxDecoration(
                  //                         color: Color(0xFFD9D9D9),
                  //                       ),
                  //                       padding: EdgeInsets.all(6),
                  //                       child: Image.file(
                  //                         image,
                  //                         height: 64,
                  //                         width: 35,
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                     if (_isDeleteMode)
                  //                       Positioned(
                  //                         top: 0,
                  //                         right: 0,
                  //                         child: CircleAvatar(
                  //                           radius: 12,
                  //                           backgroundColor: Colors.white,
                  //                           child: Icon(
                  //                             _selectedImages[index]
                  //                                 ? Icons.check_circle
                  //                                 : Icons.circle_outlined,
                  //                             color: Colors.red,
                  //                             size: 18,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                   ],
                  //                 ),
                  //               );
                  //             }).toList(),
                  //             GestureDetector(
                  //               onTap: _pickImage,
                  //               child: Container(
                  //                 height: 75,
                  //                 width: 45,
                  //                 decoration: BoxDecoration(
                  //                   color: Color(0xFFD9D9D9),
                  //                 ),
                  //                 child: Icon(
                  //                   Icons.add,
                  //                   size: 20,
                  //                   color: primary_color,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Colors.white,
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
                                    Center(child: Text(measure["size"] ?? "")),
                                  ),
                                  DataCell(
                                    Center(child: Text(measure["chest"] ?? "")),
                                  ),
                                  DataCell(
                                    Center(child: Text(measure["hips"] ?? "")),
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
    );
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

          double leftPadding = index == 0 ? 0 : 10;
          double rightPadding = index == uniforms.length - 1 ? 0 : 10;

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
                    MediaQuery.of(context).size.width * 0.5, // Adjusted width
                height: 50,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.10, // 15%
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                            // add button

                            IconButton(
                               onPressed: () {
                                 _showUpdateUniformDialog(context, uniform);
                               },
                               icon: Icon(
                                 Icons.add,
                                 color: primary_color,
   ),
                             ),


                            Container(
                              width: 40,
                              child: IconButton(
                                onPressed: () {
                                  adminRepository.deleteUniform(uniform.id);
                                  Future.delayed(Duration(seconds: 1), () {
                                    BlocProvider.of<AdminExtendedBloc>(context)
                                        .add(ShowUniformsEvent(
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
                            ),
                          ],
                        ),
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
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Update Uniform Stock',
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
                  'Uniform Size: ${uniform.Size}',
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
}
