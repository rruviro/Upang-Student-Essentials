import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:use/frontend/admin/bag.dart';

import '../../colors/colors.dart';

class UniformStudent extends StatefulWidget {
  const UniformStudent({super.key});

  @override
  State<UniformStudent> createState() => _UniformAdminState();
}

class _UniformAdminState extends State<UniformStudent> {
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
                  Text(
                    "2 images",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/bsit.png',
                          height: 60,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: Image.asset(
                          'assets/uniuni.png',
                          height: 60,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildHeader('Corporate Top', '8.5k Ordered'),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                          "Size Charts",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See what size best suits you.",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
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
                        )
                      ],
                    ),
                  ),
                
                  const SizedBox(height: 30),
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
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Stock: 300',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'The Corporate Top of BSIT',
                                                    style: TextStyle(
                                                      fontSize: 12,
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
                                                padding: EdgeInsets.symmetric(horizontal: 50),
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
                                                                  ? const Color(0xFF2AB9E6) // change the text color when selected
                                                                  : Colors.black, // text color when not selected
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
                                                padding: EdgeInsets.symmetric(horizontal: 50),
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
                                                                  ? const Color(0xFF2AB9E6) // change the text color when selected
                                                                  : Colors.black, // text color when not selected
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
                                                style: TextStyle(fontSize: 16),
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
                                style: TextStyle(color: primary_color),
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
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Stock: 300',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'The Corporate Top of BSIT',
                                                    style: TextStyle(
                                                      fontSize: 12,
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
                                                padding: EdgeInsets.symmetric(horizontal: 50),
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
                                                                  ? const Color(0xFF2AB9E6) // change the text color when selected
                                                                  : Colors.black, // text color when not selected
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
                                                padding: EdgeInsets.symmetric(horizontal: 50),
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
                                                                  ? const Color(0xFF2AB9E6) // change the text color when selected
                                                                  : Colors.black, // text color when not selected
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
                                                style: TextStyle(fontSize: 16),
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
                                style: TextStyle(color: primary_color),
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

// add margin on the image and corpo top
// maximize the divider
// decrease the sizedbox height in the size same as the claim
// add border radius

  Widget _buildHeader(String title, String stockInfo) {
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
          Positioned(
            right: 16,
            top: 10,
            child: Text(
              stockInfo,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
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
                width: 70,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
