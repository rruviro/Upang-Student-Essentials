import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:use/frontend/Authentication/AdminLogin.dart';
import 'package:use/frontend/student/navigation.dart';
import 'package:use/frontend/welcome.dart';
import 'package:use/backend/bloc/authentication/authentication_bloc.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';

import '../colors/colors.dart';

final StudentBottomBloc studentBloc = StudentBottomBloc();

class StudnetLogin extends StatelessWidget {
  StudnetLogin({super.key});

  // Controllers for TextFields
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text("Logging In..."),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LoginSuccess) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Successfully: Welcome!")),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider<StudentBottomBloc>.value(
                  value: studentBloc,
                  child: SHomeBase(studentId: state.StudentId),
                ),
              ),
            );
          } else if (state is LoginError) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Incorrect Credentials: Please try again")),
            );
          }
        },
          child: Stack(
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
                          Text('Student ID', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500)),
                          SizedBox(height: 8),
                          TextField(
                            controller: studentIdController, // Add controller
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 12),
                                  Icon(Icons.person_outline,
                                      color: Colors.black),
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
                                  fontSize: 13),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12.0),
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
                          Text('Password', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500)),
                          SizedBox(height: 8),
                          PasswordField(controller: passwordController),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        //EDITED BY MIRO
                        onPressed: () {
                          String studentId = studentIdController.text;
                          String password = passwordController.text;
                          context
                              .read<AuthenticationBloc>()
                              .add(StudentLogin(studentId, password));
                        },
                        // HANGGANG DITO
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary_color,
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
                          Expanded(child: Divider(thickness: 0.5, color: tertiary_color)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("other", style: TextStyle(fontSize: 12, color: tertiary_color)),
                          ),
                          Expanded(child: Divider(thickness: 0.5, color: tertiary_color)),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider<AuthenticationBloc>.value(
                                value: authBloc,
                                child: const AdminLogin(),
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          side:
                              BorderSide(color: primary_color, width: 2.0),
                          foregroundColor: primary_color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Admin",
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
        ));
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  PasswordField({required this.controller}); // Accept controller

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // Set controller
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
        hintStyle:
            TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 13),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
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
