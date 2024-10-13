import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/studentApi/srepoimpl.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/frontend/student/bag.dart';
import 'package:use/frontend/colors/colors.dart';
import 'package:use/frontend/student/home/home.dart';

class UniformStudent extends StatefulWidget {
  final StudentProfile profile;
  final String courseName;
  final String department;
  final String type;
  final String Gender;
  final String UniformType;
  final String Body;

  const UniformStudent(
      {Key? key,
      required this.courseName,
      required this.profile,
      required this.department,
      required this.type,
      required this.Gender,
      required this.UniformType,
      required this.Body})
      : super(key: key);

  @override
  State<UniformStudent> createState() => _UniformStudentState();
}

class _UniformStudentState extends State<UniformStudent> {
  List<Uniform> uniforms = [];
  List<StudentBagItem> items = [];
  String? _course;

  @override
  void initState() {
    super.initState();
    getUnforms();
    BlocProvider.of<StudentExtendedBloc>(context).add(ShowUniformsEvent(
      widget.courseName,
      widget.Gender,
      widget.UniformType,
      widget.Body,
    ));
  }

  void getUnforms() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    _course = sharedPref.getString('course');
    BlocProvider.of<StudentExtendedBloc>(context)
        .add(allstudentBagItem(widget.profile.id, "All"));
  }

  bool isUniformInBag(Uniform uniform) {
    return items
        .any((item) => item.type == widget.type && item.body == uniform.Body);
  }

  // Function to add the uniform to the bag and show success dialog
  void _addUniformToBackpack(Uniform uniform) {
    setState(() {
      items.add(StudentBagItem(
          type: widget.type,
          body: uniform.Body,
          reservationNumber: 0,
          id: 0,
          department: '',
          course: '',
          gender: '',
          size: '',
          status: '',
          claimingSchedule: '',
          stubagId: 0,
          shift: ''));
    });

    // Show the dialog with checkmark and message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 15),
                Text(
                  "Uniform Added",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
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
            context
                .read<StudentExtendedBloc>()
                .add(ShowStocksEvent(Course: widget.courseName));
            Navigator.pop(context, true);
          },
        ),
        title: Transform.translate(
          offset: const Offset(-15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uniform,',
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
          IconButton(
            icon: Icon(Icons.backpack_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<StudentExtendedBloc>.value(
                    value: studBloc,
                    child:
                        Bag(studentProfile: widget.profile, Status: "ACTIVE"),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: BlocListener<StudentExtendedBloc, StudentExtendedState>(
        listener: (context, state) {
          if (state is StudentBagItemLoadSuccessState) {
            setState(() {
              items = state.studentBagItem;
              print(items.length);
            });
          }
          if (state is UniformsLoadingState) {
            print("Loading student uniforms");
          } else if (state is UniformsLoadedState) {
            setState(() {
              uniforms = state.uniforms;
            });
            print('Student uniforms loaded');
          } else if (state is UniformsErrorState) {
            print("Error loading student uniforms: ${state.error}");
          } else {
            print("Unknown state: $state");
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
                    _buildHeader('${widget.type} ${widget.Body}'),
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
                          Text("image"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    _course != widget.courseName
                        ? Text(
                            'Not Available for your course',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: isUniformInBag(uniforms.first)
                                          ? null
                                          : () {
                                              _showAddToBackpackModal(
                                                  context, widget.type);
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.blue,
                                        side: BorderSide(color: primary_color),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minimumSize: const Size.fromHeight(60),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.add, color: primary_color),
                                          SizedBox(width: 8),
                                          Text(
                                            isUniformInBag(uniforms.first)
                                                ? 'You already have a uniform'
                                                : 'Add to Backpack',
                                            style: TextStyle(
                                                color: primary_color,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: isUniformInBag(uniforms.first)
                                          ? null
                                          : () => _showRequestModal(
                                              context, widget.type),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.blue,
                                        side: BorderSide(color: primary_color),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minimumSize: const Size.fromHeight(60),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.request_page,
                                              color: primary_color),
                                          SizedBox(width: 8),
                                          Text(
                                            isUniformInBag(uniforms.first)
                                                ? 'You already have a uniform'
                                                : 'Request',
                                            style: TextStyle(
                                                color: primary_color,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(url),
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }

  void _showAddToBackpackModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _ModalContent(
          onSubmit: (selectedUniform, selectedSchedule) {
            print('Selected Uniform ID: ${widget.profile.id}');
            print('Department: ${selectedUniform.Department}');
            print('Course: ${selectedUniform.Course}');
            print('Gender: ${selectedUniform.Gender}');
            print('Type: ${type}');
            print('Body: ${selectedUniform.Body}');
            print('Size: ${selectedUniform.Size}');
            print('Stock: ${selectedUniform.Stock}');

            context.read<StudentExtendedBloc>().add(AddStudentBagItem(
                selectedUniform.Department,
                selectedUniform.Course,
                selectedUniform.Gender,
                type,
                selectedUniform.Body,
                selectedUniform.Size,
                "ACTIVE",
                widget.profile.id,
                selectedSchedule!));
            _addUniformToBackpack(uniforms.first);
            Navigator.pop(context);
          },
          submitButtonText: 'Add to Backpack',
          submitButtonIcon: Icons.backpack,
          uniforms: uniforms, // Pass the entire list of uniforms
        );
      },
    );
  }

  void _showRequestModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _ModalContent(
          onSubmit: (selectedUniform, selectedSchedule) {
            // Print all properties of the selected uniform
            print('Selected Uniform ID: ${widget.profile.id}');
            print('Department: ${selectedUniform.Department}');
            print('Course: ${selectedUniform.Course}');
            print('Gender: ${selectedUniform.Gender}');
            print('Type: ${type}');
            print('Body: ${selectedUniform.Body}');
            print('Size: ${selectedUniform.Size}');
            print('Stock: ${selectedUniform.Stock}');
            if (selectedUniform.Stock != 0) {
              print(
                  "@!@!@!@!@!@!@!@!@!@!@!@!!@!!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!");
              context.read<StudentExtendedBloc>().add(itemreduceStocks(
                  count: 1,
                  department: selectedUniform.Department,
                  course: selectedUniform.Course,
                  gender: selectedUniform.Gender,
                  type: type,
                  body: selectedUniform.Body,
                  size: selectedUniform.Size));
            }
            context.read<StudentExtendedBloc>().add(AddReserveBagItem(
                selectedUniform.Department,
                selectedUniform.Course,
                selectedUniform.Gender,
                type,
                selectedUniform.Body,
                selectedUniform.Size,
                "Request",
                widget.profile.id,
                selectedSchedule!,
                selectedUniform.Stock));
            _addUniformToBackpack(uniforms.first);
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
  final Function(Uniform, String?) onSubmit;
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
  List<Map<String, String>> schedules = [
    {'display': 'Shift A: M|T|W', 'value': 'A'},
    {'display': 'Shift B: TH|F|S', 'value': 'B'}
  ];

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
                child: Text(size),
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
                value: schedule['value'], // Use the corresponding value
                child: Text(schedule['display']!), // Display text
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
                  widget.onSubmit(selectedUniform,
                      selectedSchedule); // Pass the selected Uniform
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
