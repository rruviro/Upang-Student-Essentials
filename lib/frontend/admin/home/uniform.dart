import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:use/frontend/colors/colors.dart';

class UniformAdmin extends StatefulWidget {
  const UniformAdmin({super.key});

  @override
  State<UniformAdmin> createState() => _UniformAdminState();
}

class _UniformAdminState extends State<UniformAdmin> {
  String? selectedSize;
  String? selectedSchedule;
  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  List<String> schedules = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

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

  void addSize() {
    setState(() {
      measures.add({"size": "New Size", "chest": "", "hips": ""});
    });
  }

  void deleteSize(int index) {
    setState(() {
      measures.removeAt(index);
    });
  }

  void _toggleDeleteMode() {
    setState(() {
      _isDeleteMode = !_isDeleteMode;
      if (_isDeleteMode) {
        if (_selectedImages.length != _images.length) {
          _selectedImages = List.filled(_images.length, false);
        }
      } else {
        _selectedImages = List.filled(_images.length, false);
      }
    });
  }

  void _selectImage(int index) {
    if (index < 0 || index >= _selectedImages.length) {
      print('Invalid index: $index, _selectedImages length: ${_selectedImages.length}');
      return;
    }
    setState(() {
      _selectedImages[index] = !_selectedImages[index];
    });
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        _selectedImages.add(false);
      });
    } else {
      print('No image selected.');
    }
  }

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

  void showSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.grey[100],
          title: const Text(
            "Manage Sizes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 10,
                      dataRowHeight: 40,
                      columns: const [
                        DataColumn(label: Center(child: Text("SIZE", style: TextStyle(fontSize: 12)))),
                        DataColumn(label: Center(child: Text("CHEST", style: TextStyle(fontSize: 12)))),
                        DataColumn(label: Center(child: Text("HIPS", style: TextStyle(fontSize: 12)))),
                        DataColumn(label: Center(child: Text("", style: TextStyle(fontSize: 12)))),
                      ],
                      rows: measures.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> sizeData = entry.value;

                        return DataRow(cells: [
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                initialValue: sizeData["size"],
                                onChanged: (value) {
                                  setState(() {
                                    measures[index]["size"] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                initialValue: sizeData["chest"],
                                onChanged: (value) {
                                  setState(() {
                                    measures[index]["chest"] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                initialValue: sizeData["hips"],
                                onChanged: (value) {
                                  setState(() {
                                    measures[index]["hips"] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red, size: 18),
                              onPressed: () {
                                deleteSize(index);
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.add, color: Colors.white, size: 16),
                  label: Text("Add Size", style: TextStyle(color: Colors.white, fontSize: 12)),
                  onPressed: () {
                    addSize();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primary_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close", style: TextStyle(color: Colors.white, fontSize: 12)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Are you sure you want to delete?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _deleteSelectedImages();
                Navigator.of(context).pop();
              },
            ),
          ],
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
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: const Offset(-15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Uniform',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Course:',
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
              children: [
                const Text(
                  'Year',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                const Text(
                  'First Year',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
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
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.10),
                        blurRadius: 5,
                        offset: Offset(1, 7),
                      ),
                    ],
                  ),
                  child: slides(context),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_images.length + 2} Images",
                        style: TextStyle(fontSize: 13),
                      ),
                      if (_images.isNotEmpty)
                        IconButton(
                          icon: Icon(
                            _isDeleteMode ? Icons.check : Icons.delete,
                            color: _isDeleteMode ? Colors.green : Colors.red,
                          ),
                          onPressed: () {
                            if (_isDeleteMode) {
                              _showDeleteConfirmation();
                            } else {
                              _toggleDeleteMode();
                            }
                          },
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/bsit.png',
                            height: 60,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/uniuni.png',
                            height: 60,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        ..._images.asMap().entries.map((entry) {
                          int index = entry.key;
                          File image = entry.value;

                          return GestureDetector(
                            onTap: () {
                              if (_isDeleteMode) {
                                _selectImage(index);
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                  ),

                                  padding: EdgeInsets.all(6),
                                  child: Image.file(
                                    image,
                                    height: 64,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (_isDeleteMode)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        _selectedImages[index]
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 75,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: primary_color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildHeader('Corporate Top', '8.5k Ordered'),
                  const SizedBox(height: 15),
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
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "See what size best suits you.",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: primary_color),
                        onPressed: () {
                          showSizeDialog(context);
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 330,
                    width: 460,
                    color: Colors.white,
                    child: Container(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Center(child: Text("SIZE"))),
                          DataColumn(label: Center(child: Text("CHEST"))),
                          DataColumn(label: Center(child: Text("HIPS"))),
                        ],
                        rows: measures.map((measure) {
                          return DataRow(cells: [
                            DataCell(Center(child: Text(measure["size"] ?? ""))),
                            DataCell(Center(child: Text(measure["chest"] ?? ""))),
                            DataCell(Center(child: Text(measure["hips"] ?? ""))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showModalBottomSheet(context, "Add to Backpack"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primary_color,
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
                                style: TextStyle(color: primary_color, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showModalBottomSheet(context, "Request"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primary_color,
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
                                style: TextStyle(color: primary_color, fontSize: 10),
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
    );
  }

  Widget _buildHeader(String title, String stockInfo) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                stockInfo,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Ordered",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget slides(BuildContext context) {
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

  void _showModalBottomSheet(BuildContext context, String action) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          child: Image.asset(
                            'assets/uniuni.png',
                            height: 170,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Corporate Top',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Stock: 300',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'The Corporate Top of BSIT',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Sizes',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: sizes.map((size) {
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              if (selectedSize == size) {
                                selectedSize = null;
                              } else {
                                selectedSize = size;
                              }
                            });
                          },
                          child: Container(
                            width: 50,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedSize == size ? primary_color : const Color(0xFFD9D9D9),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                size,
                                style: TextStyle(
                                  color: selectedSize == size ? Colors.white : const Color(0xFFB0B0B0),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    Divider(color: Colors.grey),
                    const SizedBox(height: 30),
                    const Text(
                      "Claim Schedule",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildShiftContainer("Shift A", schedules.sublist(0, 3), setModalState),
                    const SizedBox(height: 20),
                    _buildShiftContainer("Shift B", schedules.sublist(3), setModalState),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (selectedSize != null && selectedSchedule != null) {
                            print('$action: Size - $selectedSize, Schedule - $selectedSchedule');
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary_color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(action == "Add to Backpack" ? Icons.backpack : Icons.request_page, size: 20),
                        label: Text(
                          action,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildShiftContainer(String shiftName, List<String> shiftDays, StateSetter setModalState) {
    bool isShiftSelected = shiftDays.contains(selectedSchedule);
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isShiftSelected ? primary_color : const Color(0xFFD9D9D9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              shiftName,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Container(
            height: double.infinity,
            child: VerticalDivider(
              color: Colors.white,
              width: 20,
              thickness: 1,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: shiftDays.map((day) {
                final isSelected = selectedSchedule == day;
                return GestureDetector(
                  onTap: () {
                    setModalState(() {
                      if (selectedSchedule == day) {
                        selectedSchedule = null;
                      } else {
                        selectedSchedule = day;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? primary_color : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}