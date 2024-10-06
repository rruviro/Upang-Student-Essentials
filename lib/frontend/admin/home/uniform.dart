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
  int selectedMaleIndexTop = -1;
  int selectedFemaleIndexTop = -1;

  bool isChecked1 = false;
  bool isChecked2 = false;

  String selectedSize = "M";
  bool isDropdownVisible = false;
  List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL"];

  final List<String> days = ["Mon", "Tue", "Wed"];
  final List<String> days2 = ["Thu", "Fri", "Sat"];
  int? selectedDayIndexA;
  int? selectedDayIndexB;

  int? selectedShift;

  List<Map<String, String>> measures = [
    {"size": "XS", "chest": "17.5", "hips": "25.5"},
    {"size": "S", "chest": "18.5", "hips": "26.5"},
    {"size": "M", "chest": "19.5", "hips": "27.5"},
    {"size": "L", "chest": "20.5", "hips": "28.5"},
    {"size": "XL", "chest": "21.5", "hips": "29.5"},
    {"size": "XXL", "chest": "22.5", "hips": "30.5"},
  ];

  void addSize() {
    setState(() {
      measures.add({"size:": "New Size", "Chest": "hips"});
    });
  }

  void deleteSize(int index) {
    setState(() {
      measures.removeAt(index);
    });
  }

 void showSizeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.grey[100],
        title: const Center(
          child: Text(
            "Manage Sizes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        content: Container(
          height: 350,
          width: 500,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(label: Text("SIZE", textAlign: TextAlign.center)),
                      DataColumn(label: Text("CHEST", textAlign: TextAlign.center)),
                      DataColumn(label: Text("HIPS", textAlign: TextAlign.center)),
                      DataColumn(label: Text("ACTIONS", textAlign: TextAlign.center)),
                    ],
                    rows: measures.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> sizeData = entry.value;

                      return DataRow(cells: [
                        DataCell(Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Size',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: TextEditingController(text: sizeData["size"]),
                            onChanged: (value) {
                              setState(() {
                                measures[index]["size"] = value;
                              });
                            },
                          ),
                        )),
                        DataCell(Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Chest',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: TextEditingController(text: sizeData["chest"]),
                            onChanged: (value) {
                              setState(() {
                                measures[index]["chest"] = value;
                              });
                            },
                          ),
                        )),
                        DataCell(Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Hips',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: TextEditingController(text: sizeData["hips"]),
                            onChanged: (value) {
                              setState(() {
                                measures[index]["hips"] = value;
                              });
                            },
                          ),
                        )),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add Size"),
                  onPressed: () {
                    addSize();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    backgroundColor: Color(0xFF0EAA72), // Gradient button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    backgroundColor: Colors.grey[600], // Grey close button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}



  List<File> _images = [];
  List<bool> _selectedImages =[];
  bool _isDeleteMode = false;

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
          // Do not reset _selectedImages here
      });
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
                              color: Color(0xFF2AB9E6),
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
                        icon: Icon(Icons.add, color: Colors.black),
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
                          DataColumn(label: Text("SIZE", textAlign: TextAlign.center)),
                          DataColumn(label: Text("CHEST", textAlign: TextAlign.center)),
                          DataColumn(label: Text("HIPS", textAlign: TextAlign.center)),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Center(child: Text("XS"))),
                            DataCell(Center(child: Text("17.5"))),
                            DataCell(Center(child: Text("25.5"))),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text("S"))),
                            DataCell(Center(child: Text("18.5"))),
                            DataCell(Center(child: Text("26.5"))),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text("M"))),
                            DataCell(Center(child: Text("19.5"))),
                            DataCell(Center(child: Text("27.5"))),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text("L"))),
                            DataCell(Center(child: Text("20.5"))),
                            DataCell(Center(child: Text("28.5"))),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text("XL"))),
                            DataCell(Center(child: Text("21.5"))),
                            DataCell(Center(child: Text("29.5"))),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text("XXL"))),
                            DataCell(Center(child: Text("22.5"))),
                            DataCell(Center(child: Text("30.5"))),
                          ]),
                        ],
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
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
                                              padding: const EdgeInsets.all(30), // image padding only
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

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            height: 1,
                                          ),
                                        ),

                                        const SizedBox(height: 16),

                                        _buildItemCard(
                                          'Sizes',
                                          '',
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                          ),
                                          selectedMaleIndexTop,
                                          (index) {
                                            setState(() {
                                              selectedMaleIndexTop = selectedMaleIndexTop == index ? -1 : index;
                                            });
                                          },
                                          isDisabled: selectedFemaleIndexTop != -1,
                                        ),
                                        
                                        const SizedBox(height: 30),

                                        Divider(color: Colors.grey),

                                        const SizedBox(height: 30),

                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Claim Schedule",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          height: 70,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectedDayIndexA != null ? const Color(0xFF2AB9E6) : const Color(0xFFD9D9D9),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Text(
                                                  "Shift A",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                height: double.infinity,
                                                child: VerticalDivider(
                                                  color: tertiary_color,
                                                  width: 20,
                                                  thickness: 1,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: List.generate(days.length, (index) {
                                                    final isSelected = selectedDayIndexA == index;
                                                    final isClickable = selectedDayIndexB == null;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (isClickable) {
                                                          setState(() {
                                                            selectedDayIndexA = isSelected ? null : index;
                                                          });
                                                        }
                                                      },
                                                      child: AbsorbPointer(
                                                        absorbing: !isClickable,
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
                                                            days[index],
                                                            style: TextStyle(
                                                              color: isSelected
                                                                  ? const Color(0xFF2AB9E6)
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 70,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectedDayIndexB != null ? const Color(0xFF2AB9E6) : const Color(0xFFD9D9D9),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Text("Shift B", style: TextStyle(color: Colors.black)),
                                              ),
                                              VerticalDivider(
                                                color: tertiary_color,
                                                width: 20,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: List.generate(days2.length, (index) {
                                                    final isSelected = selectedDayIndexB == index;
                                                    final isClickable = selectedDayIndexA == null;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (isClickable) {
                                                          setState(() {
                                                            selectedDayIndexB = isSelected ? null : index;
                                                          });
                                                        }
                                                      },
                                                      child: AbsorbPointer(
                                                        absorbing: !isClickable,
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
                                                            days2[index],
                                                            style: TextStyle(
                                                              color: isSelected
                                                                  ? const Color(0xFF2AB9E6)
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                // action
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF2AB9E6),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              icon: const Icon(Icons.backpack, size: 20),
                                              label: const Text(
                                                "Add to Backpack",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0EAA72),
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
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
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
                                              padding: const EdgeInsets.all(20), // image padding only
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

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            height: 1,
                                          ),
                                        ),

                                        const SizedBox(height: 16),

                                        _buildItemCard(
                                          'Sizes',
                                          '',
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                          ),
                                          selectedMaleIndexTop,
                                          (index) {
                                            setState(() {
                                              selectedMaleIndexTop = selectedMaleIndexTop == index ? -1 : index;
                                            });
                                          },
                                          isDisabled: selectedFemaleIndexTop != -1,
                                        ),
                                        
                                        const SizedBox(height: 30),

                                        Divider(color: Colors.grey),

                                        const SizedBox(height: 30),

                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Claim Schedule",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          height: 70,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectedDayIndexA != null ? const Color(0xFF2AB9E6) : const Color(0xFFD9D9D9),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Text(
                                                  "Shift A",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                height: double.infinity,
                                                child: VerticalDivider(
                                                  color: tertiary_color,
                                                  width: 20,
                                                  thickness: 1,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: List.generate(days.length, (index) {
                                                    final isSelected = selectedDayIndexA == index;
                                                    final isClickable = selectedDayIndexB == null;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (isClickable) {
                                                          setState(() {
                                                            selectedDayIndexA = isSelected ? null : index;
                                                          });
                                                        }
                                                      },
                                                      child: AbsorbPointer(
                                                        absorbing: !isClickable,
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
                                                            days[index],
                                                            style: TextStyle(
                                                              color: isSelected
                                                                  ? const Color(0xFF2AB9E6)
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 70,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectedDayIndexB != null ? const Color(0xFF2AB9E6) : const Color(0xFFD9D9D9),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Text("Shift B", style: TextStyle(color: Colors.black)),
                                              ),
                                              VerticalDivider(
                                                color: tertiary_color,
                                                width: 20,
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: List.generate(days2.length, (index) {
                                                    final isSelected = selectedDayIndexB == index;
                                                    final isClickable = selectedDayIndexA == null;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (isClickable) {
                                                          setState(() {
                                                            selectedDayIndexB = isSelected ? null : index;
                                                          });
                                                        }
                                                      },
                                                      child: AbsorbPointer(
                                                        absorbing: !isClickable,
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
                                                            days2[index],
                                                            style: TextStyle(
                                                              color: isSelected
                                                                  ? const Color(0xFF2AB9E6)
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                // action
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF2AB9E6),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              icon: const Icon(Icons.request_page, size: 20),
                                              label: const Text(
                                                "Request",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0EAA72),
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

Widget _buildItemCard(
  String title,
  String subtitle,
  Widget leading,
  int selectedIndex,
  Function(int) onSizeSelected, {
  bool isDisabled = false,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: null,
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading,
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
            int index = ['XS', 'S', 'M', 'L', 'XL', 'XXL'].indexOf(size);
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: isDisabled ? null : () {
                onSizeSelected(index);
              },
              child: SizedBox(
                width: 50,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? const Color(0xFF2AB9E6) : const Color(0xFFD9D9D9),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFFB0B0B0), 
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
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
}