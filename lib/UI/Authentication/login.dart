// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/loginbg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 400,
                    height: 200,
                  ),
                ),
                SizedBox(height: 30),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Student ID', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 12),
                              Icon(Icons.person_outline, color: Colors.black),
                              SizedBox(width: 8),
                              Container(
                                width: 1.0,
                                height: 20.0,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          hintText: 'XX-XXXX-XXXXXX',
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      PasswordField(),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // login function chuchu
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: Color(0xFF0EAA72),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Divider(color: Colors.black)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("other", style: TextStyle(color: Colors.black)),
                      ),
                      Expanded(child: Divider(color: Colors.black)),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // admin function
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color(0xFF0EAA72), width: 2.0),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text(
                    "Admin",
                    style: TextStyle(
                      color: Color(0xFF0EAA72),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 12),
            Icon(Icons.lock_outline, color: Colors.black),
            SizedBox(width: 8),
            Container(
              width: 1.0,
              height: 20.0,
              color: Colors.black,
            ),
            SizedBox(width: 8),
          ],
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
