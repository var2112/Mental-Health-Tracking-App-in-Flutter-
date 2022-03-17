//LoginPage by Varun Kamble

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_space/pages/home_page.dart';
import 'package:my_space/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //Firebase
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/top.png'),
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log In",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Log in to your account to continue",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter your email");
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return ("Please enter a valid email id");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Your Email Address*",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[500],
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          RegExp regex = new RegExp(r"^.{6,}$");
                          if (value!.isEmpty) {
                            return ("Please enter your password");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please enter a password(Min 6 character)");
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Your Password*",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.grey[500],
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  LogIn(emailController.text, passwordController.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Color(0xfff7a73e),
                padding:
                    EdgeInsets.only(left: 80, right: 80, top: 15, bottom: 15),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Forgotten your password >",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )),
              SizedBox(
                height: 7,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    "Sign Up >",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "About Us >",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ));
  }

  void LogIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage())),
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message,
            backgroundColor: Color(0xfff7a73e),
            textColor: Color(0xFFFFFFFF));
      });
    }
  }
}
