import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/frontend/admin/bag.dart';
import 'package:use/frontend/colors/colors.dart';

class UniformStudent extends StatefulWidget {
  final String courseName;

  const UniformStudent({Key? key, required this.courseName}) : super(key: key);

  @override
  State<UniformStudent> createState() => _UniformStudentState();
}

class _UniformStudentState extends State<UniformStudent> {
  List<Uniform> uniforms = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentExtendedBloc>(context)
        .add(ShowUniformsEvent(Course: widget.courseName));
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
          },
        ),
        title: Transform.translate(
          offset: const Offset(-15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uniform',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Course: ${widget.courseName}',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
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
      body: BlocListener<StudentExtendedBloc, StudentExtendedState>(
        listener: (context, state) {
          if (state is UniformsLoadingState) {
            print("Loading student uniforms");
          } else if (state is UniformsLoadedState) {
            setState(() {
              uniforms = state.uniforms;
            });
            print('Student uniforms loaded');
          } else if (state is UniformsErrorState) {
            print("Error loading student uniforms: ${state.error}");
          }
        },
        child: SingleChildScrollView(
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
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 5,
                          offset: Offset(1, 7),
                        ),
                      ],
                    ),
                    child: _buildSlides(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildHeader('Corporate Top'),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Size Charts",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See what size best suits you.",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: 460,
                      color: Color(0xFFD9D9D9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "image",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showAddToBackpackModal(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              side: BorderSide(color: primary_color),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size.fromHeight(60),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: primary_color),
                                SizedBox(width: 8),
                                Text(
                                  'Add to Backpack',
                                  style: TextStyle(
                                      color: primary_color, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showRequestModal(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              side: BorderSide(color: primary_color),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size.fromHeight(60),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.request_page, color: primary_color),
                                SizedBox(width: 8),
                                Text(
                                  'Request',
                                  style: TextStyle(
                                      color: primary_color, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlides() {
    List<String> imageUrls = ['assets/bsit.png', 'assets/uniuni.png'];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider(
        items: imageUrls.map((url) {
          return Container(
            width: 200,
            margin: EdgeInsets.symmetric(horizontal: 0),
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
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 600),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  void _showAddToBackpackModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _ModalContent(
          onSubmit: (selectedUniform) {
            // Print all properties of the selected uniform
            print('Selected Uniform ID: ${selectedUniform.id}');
            print('Department: ${selectedUniform.Department}');
            print('Course: ${selectedUniform.Course}');
            print('Gender: ${selectedUniform.Gender}');
            print('Type: ${selectedUniform.Type}');
            print('Body: ${selectedUniform.Body}');
            print('Size: ${selectedUniform.Size}');
            print('Stock: ${selectedUniform.Stock}');
            Navigator.pop(context);
          },
          submitButtonText: 'Add to Backpack',
          submitButtonIcon: Icons.backpack,
          uniforms: uniforms, // Pass the entire list of uniforms
        );
      },
    );
  }

  void _showRequestModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _ModalContent(
          onSubmit: (selectedUniform) {
            // Print all properties of the selected uniform
            print('Selected Uniform ID: ${selectedUniform.id}');
            print('Department: ${selectedUniform.Department}');
            print('Course: ${selectedUniform.Course}');
            print('Gender: ${selectedUniform.Gender}');
            print('Type: ${selectedUniform.Type}');
            print('Body: ${selectedUniform.Body}');
            print('Size: ${selectedUniform.Size}');
            print('Stock: ${selectedUniform.Stock}');
            Navigator.pop(context);
          },
          submitButtonText: 'Request',
          submitButtonIcon: Icons.request_page,
          uniforms: uniforms,
        );
      },
    );
  }
}

class _ModalContent extends StatefulWidget {
  final Function(Uniform) onSubmit; // Change to accept a Uniform object
  final String submitButtonText;
  final IconData submitButtonIcon;
  final List<Uniform> uniforms; // Pass the list of uniforms

  const _ModalContent({
    Key? key,
    required this.onSubmit,
    required this.submitButtonText,
    required this.submitButtonIcon,
    required this.uniforms, // Change from sizes to uniforms
  }) : super(key: key);

  @override
  _ModalContentState createState() => _ModalContentState();
}

class _ModalContentState extends State<_ModalContent> {
  String? selectedSize; // Track the selected size
  String? selectedSchedule;
  List<String> schedules = ['Shift A', 'Shift B'];

  @override
  Widget build(BuildContext context) {
    // Get unique sizes from the uniforms
    final uniqueSizes = widget.uniforms.map((u) => u.Size).toSet().toList();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Size and Schedule',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedSize,
            hint: Text('Select Size'),
            items: uniqueSizes.map((size) {
              return DropdownMenuItem(
                value: size,
                child: Text(size), // Display the size
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSize = value; // Set the selected size
              });
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedSchedule,
            hint: Text('Select Schedule'),
            items: schedules.map((schedule) {
              return DropdownMenuItem(
                value: schedule,
                child: Text(schedule),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSchedule = value; // Set the selected schedule
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (selectedSize != null && selectedSchedule != null) {
                // Find the corresponding Uniform by Size
                Uniform? selectedUniform = widget.uniforms.firstWhere(
                      (uniform) => uniform.Size == selectedSize,
                );

                if (selectedUniform != null) {
                  widget.onSubmit(selectedUniform); // Pass the selected Uniform
                } else {
                  print('No matching uniform found for size: $selectedSize');
                }
              } else {
                print('Please select a size and schedule.');
              }
            },
            icon: Icon(widget.submitButtonIcon),
            label: Text(widget.submitButtonText),
          ),
        ],
      ),
    );
  }
}