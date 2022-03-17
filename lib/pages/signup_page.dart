//SignUpPage by Varun Kamble

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:my_space/pages/home_page.dart';

import '../model/user_model.dart';
import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool value = false;
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = new TextEditingController();

  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
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
                height: 2,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Create your account.. it is completely free",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Your email address*",
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
                        controller: nameEditingController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Your name*",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.person,
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
                        controller: passwordEditingController,
                        obscureText: true,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          nameEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Your password*",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.vpn_key,
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
                        controller: confirmPasswordEditingController,
                        obscureText: true,
                        validator: (value) {
                          if (confirmPasswordEditingController.text !=
                              passwordEditingController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmPasswordEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                            hintText: "Confirm your password*",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.vpn_key,
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
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value!;
                          });
                        }),
                    Text(
                      'I agree to the terms and condition.',
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: () {
                  signUp(emailEditingController.text,
                      passwordEditingController.text);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Color(0xfff7a73e),
                padding:
                    EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
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
                    "Already have an account >",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        )));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully :) ",
        backgroundColor: Color(0xfff7a73e),
        textColor: Color(0xFFFFFFFF));

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
