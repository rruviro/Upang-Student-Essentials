// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/frontend/authentication/StudentLogin.dart';
import 'package:use/frontend/admin/navigation.dart';

import '../admin/home/home.dart';

final AdminBottomBloc adminBloc = AdminBottomBloc();
class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 330,
                    height: 180,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Faculty ID', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
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
                              SizedBox(width: 12),
                            ],
                          ),
                          hintText: 'XX-XXXX-XXXXXX',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 13
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      PasswordField(),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider<AdminBottomBloc>.value(
                            value: adminBloc,
                            child: const HomeBase(),
                          ),
                        )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0EAA72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Divider(color: Color.fromARGB(86, 0, 0, 0))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("other", style: TextStyle(color: Color.fromARGB(86, 0, 0, 0))),
                      ),
                      Expanded(child: Divider(color: Color.fromARGB(86, 0, 0, 0))),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => StudnetLogin()
                        )
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFF0EAA72), width: 2.0),
                      foregroundColor: Color(0xFF0EAA72),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Student",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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
            SizedBox(width: 12),
          ],
        ),
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.3),
          fontSize: 13
        ),
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
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
