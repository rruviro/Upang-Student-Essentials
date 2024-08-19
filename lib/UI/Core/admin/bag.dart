import "package:flutter/material.dart";

void main() => runApp(MaterialApp(
  home: Bag(),
));

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => BagState();
}

class BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0EAA72),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Backpack', style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}