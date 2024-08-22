import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  // Track selected items for bottom sheet and container separately
  List<bool> _bottomSheetSelectedBooks = List.generate(5, (index) => false);
  List<bool> _containerSelectedBooks = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0EAA72),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stocks',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Course: ',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Year',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                SizedBox(height: 4),
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(height: 4),
                Text(
                  'First Year',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uniform',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 550,
                        width: 300, // Increased width
                        margin: EdgeInsets.only(right: 16),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF0EAA72),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/unif_top.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 350,
                        width: 300, // Increased width
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF0EAA72),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/unif_bottom.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Books',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF0EAA72),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(1, 8),
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
                              Text(
                                'Books',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Changed text color to black
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: ListView(
                                  children: [
                                    BookTile(
                                      index: 1,
                                      isSelected: _bottomSheetSelectedBooks[0],
                                      onChanged: (value) {
                                        setState(() {
                                          _bottomSheetSelectedBooks[0] = value ?? false;
                                        });
                                      },
                                    ),
                                    BookTile(
                                      index: 2,
                                      isSelected: _bottomSheetSelectedBooks[1],
                                      onChanged: (value) {
                                        setState(() {
                                          _bottomSheetSelectedBooks[1] = value ?? false;
                                        });
                                      },
                                    ),
                                    BookTile(
                                      index: 3,
                                      isSelected: _bottomSheetSelectedBooks[2],
                                      onChanged: (value) {
                                        setState(() {
                                          _bottomSheetSelectedBooks[2] = value ?? false;
                                        });
                                      },
                                    ),
                                    BookTile(
                                      index: 4,
                                      isSelected: _bottomSheetSelectedBooks[3],
                                      onChanged: (value) {
                                        setState(() {
                                          _bottomSheetSelectedBooks[3] = value ?? false;
                                        });
                                      },
                                    ),
                                    BookTile(
                                      index: 5,
                                      isSelected: _bottomSheetSelectedBooks[4],
                                      onChanged: (value) {
                                        setState(() {
                                          _bottomSheetSelectedBooks[4] = value ?? false;
                                        });
                                      },
                                    ),
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
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.apps,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 23,
                        left: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Books',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.white, // Text color in container
                              ),
                            ),
                            Text(
                              'as bundle',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.5), // Text color in container
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xFF0EAA72),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(1, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      BookTile(
                        index: 1,
                        isSelected: _containerSelectedBooks[0],
                        onChanged: (value) {
                          setState(() {
                            _containerSelectedBooks[0] = value ?? false;
                          });
                        },
                      ),
                      BookTile(
                        index: 2,
                        isSelected: _containerSelectedBooks[1],
                        onChanged: (value) {
                          setState(() {
                            _containerSelectedBooks[1] = value ?? false;
                          });
                        },
                      ),
                      BookTile(
                        index: 3,
                        isSelected: _containerSelectedBooks[2],
                        onChanged: (value) {
                          setState(() {
                            _containerSelectedBooks[2] = value ?? false;
                          });
                        },
                      ),
                      BookTile(
                        index: 4,
                        isSelected: _containerSelectedBooks[3],
                        onChanged: (value) {
                          setState(() {
                            _containerSelectedBooks[3] = value ?? false;
                          });
                        },
                      ),
                      BookTile(
                        index: 5,
                        isSelected: _containerSelectedBooks[4],
                        onChanged: (value) {
                          setState(() {
                            _containerSelectedBooks[4] = value ?? false;
                          });
                        },
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
  }
}

class BookTile extends StatelessWidget {
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const BookTile({
    required this.index,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Book $index',
            style: TextStyle(color: Colors.white), // Changed text color to white
          ),
          subtitle: Text(
            'Subtitle for Book $index',
            style: TextStyle(color: Colors.white.withOpacity(0.7)), // Changed text color to white
          ),
          iconColor: Colors.white, // Changed icon color to white
          leading: Icon(Icons.book),
          trailing: CustomCircularCheckbox(
            value: isSelected,
            onChanged: onChanged,
          ),
        ),
        Divider(
          color: Color(0xFF0EAA72),
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
        width: 24,
        height: 24,
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
