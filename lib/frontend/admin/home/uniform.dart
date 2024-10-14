import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
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
              actions: [
                const SizedBox(
                  height: 25,
                  width: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.backpack_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 15),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      toolbarHeight: 300,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          color: primary_color,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.10),
                              blurRadius: 5,
                              offset: const Offset(1, 7),
                            ),
                          ],
                        ),
                        child: Image.network(widget.stock.photoUrl),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Row without the Plus Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.stock.stockName}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // Removed the IconButton here
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  uniformsList(state.uniforms),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: uniforms.length,
      itemBuilder: (context, index) {
        final uniform = uniforms[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Size: ${uniform.Size}'),
                Text(
                  'Stock: ${uniform.Stock}',
                  style: TextStyle(
                    color: uniform.Stock > 0 ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  'Reserved: ${uniform.Reserved}',
                  style: TextStyle(
                    color: uniform.Reserved > 0 ? Colors.green : Colors.red,
                  ),
                ),

                // Update and delete buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _showUpdateUniformDialog(context, uniform); // update
                      },
                      child: const Text('Add Stocks'),
                    ),
                    /*TextButton(
                      onPressed: () {
                        _deleteUniform(uniform.id); // delete
                      },
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.red)),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ADD UNIFORM DAPAT ITO PERO EDIT LANG NEED

  // Future<void> _showAddUniformDialog(BuildContext context) async {
  //   // No need to manually input Department and Course since they're automatically assigned
  //   TextEditingController genderController = TextEditingController();
  //   TextEditingController typeController = TextEditingController();
  //   TextEditingController bodyController = TextEditingController();
  //   TextEditingController sizeController = TextEditingController();
  //   TextEditingController stockController = TextEditingController();
  //
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Add Uniform'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               TextField(controller: genderController, decoration: const InputDecoration(labelText: 'Gender')),
  //               TextField(controller: typeController, decoration: const InputDecoration(labelText: 'Type')),
  //               TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'Body')),
  //               TextField(controller: sizeController, decoration: const InputDecoration(labelText: 'Size')),
  //               TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock')),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Add uniform logic
  //               _addUniform(
  //                 widget.Department, // Automatically set Department
  //                 widget.courseName,  // Automatically set Course
  //                 genderController.text,
  //                 typeController.text,
  //                 bodyController.text,
  //                 sizeController.text,
  //                 int.parse(stockController.text),
  //               );
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // UPDATE SHOW DIALOG
  Future<void> _showUpdateUniformDialog(
      BuildContext context, Uniform uniform) async {
    TextEditingController stockController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Uniform Stock'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (stockController.text.isNotEmpty) {
                  BlocProvider.of<AdminExtendedBloc>(context).add(
                    itemreservefirst(
                      int.parse(stockController.text),
                      widget.courseName,
                      uniform.Gender,
                      uniform.Type,
                      uniform.Body,
                      uniform.Size,
                    ),
                  );
                  BlocProvider.of<AdminExtendedBloc>(context)
                      .add(ShowUniformsEvent(
                    widget.courseName,
                    widget.stock.Gender,
                    widget.stock.Type,
                    widget.stock.Body,
                  ));
                  Navigator.of(context).pop();
                } else {
                  print('Stock input is empty');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateUniform(int id, String department, String course, String gender,
      String type, String body, String size, int stock) {}

  void _deleteUniform(int id) {}
}
